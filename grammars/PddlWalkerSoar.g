tree grammar PddlWalkerSoar;

options {
	tokenVocab = Pddl;
	ASTLabelType=CommonTree;
	output=template;
}

@header {
    import java.util.HashMap;
}

@members {
    List object_types = new ArrayList();
    HashMap pred_params = new HashMap();
    //List<Pair> object_types = new ArrayList<Pair>();
}

pddlDoc : domain -> {$st = $domain.st;}
        | problem
        ;

/************* DOMAINS ****************************/

domain
scope {
  String name;
}
    : ^(DOMAIN domainName {$domain::name=$domainName.st.toString();} requireDef? typesDef?
                constantsDef? predicatesDef? (effects+=structureDef)*)
      -> agent(domainname={$domainName.st.toString()}, productions={$effects})
    ;

domainName
    : ^(DOMAIN_NAME NAME) -> {%{$NAME.text.replaceAll("-","__")}} ;

requireDef
    : ^(REQUIREMENTS REQUIRE_KEY+)
    ;

typesDef returns [List types]
	: ^(TYPES (n+=NAME)+) {$types=$n;}
	;

typedNameList[boolean obj_decs] returns [List names]
    : {$names=new ArrayList();} 
      (n=singleTypedName {obj_decs}? {object_types.add(new Pair($n.n,$n.t));}
                                     {$names.add($n.n);})+ 
    ;

singleTypedName returns [String n, String t]
    : ^(NAME type) {$n=$NAME.text.replaceAll("-","__");$t=($type.st!=null?$type.st.toString():"object");};

type
	: ^(EITHER_TYPE primType+)
	| primType {$st=$primType.st;}
	| NO_TYPE
	;

primType : NAME -> {%{$NAME.text.replaceAll("-","__")}};

constantsDef
	: ^(CONSTANTS typedNameList[false])
	;

predicatesDef
	: ^(PREDICATES atomicFormulaSkeleton+) ;

atomicFormulaSkeleton
  : ^(predicate (v=typedVariableList[false, ""])) { pred_params.put($predicate.st.toString(),$v.varmap); }
  ;

predicate : NAME -> {%{$NAME.text.replaceAll("-","__")}};

typedVariableList[boolean needtypes, String sub] returns [List varmap]
    @init {$varmap=new ArrayList();} 
    : (v=singleTypeVar[$sub] {$varmap.add($needtypes?new Pair($v.n,$v.t):$v.n);})*
    ;

/* If we need types and a variable doesn't have a type defined, return sub as
 * type */
singleTypeVar[String sub] returns [String n, String t]
    : ^(VAR NAME type) {$n=$NAME.text.replaceAll("-","__");$t=($type.st!=null?$type.st.toString():$sub);} ;

structureDef : actionDef {$st=$actionDef.st;} ;

var	: ^(VAR NAME) -> {%{$NAME.text.replaceAll("-","__")}} ;

/************* ACTIONS ****************************/

actionDef
  : ^(ACTION actionSymbol (vars=typedVariableList[true, "object"]) actionDefBody)
    -> action(domain={$domain::name}, name={$actionSymbol.st.toString()}, params={$vars.varmap}, body={$actionDefBody.st})
  ;

actionSymbol : NAME -> {%{$NAME.text.replaceAll("-","__")}};


actionDefBody
scope {
  int id_suffix;
}
@init {
  $actionDefBody::id_suffix = 0;
}
  : ^(PRECONDITION goalDesc?) ^(EFFECT effect?) {$st=$goalDesc.st;}
  ;


goalDesc
  : (t=atomicTermFormulaTest) {$st=$t.st;}
  | ^(AND_GD (t1+=goalDesc)*) -> and_test(terms={$t1}) 
  | ^(OR_GD (t2+=goalDesc)*) -> or_test(terms={$t2})
  | ^(NOT_GD (t3=goalDesc)) -> not_test(term={$t3.st})
  | ^(IMPLY_GD (a=goalDesc) (c=goalDesc)) -> imply_test(antecedent={$a.st}, consequent={$c.st})
  | ^(EXISTS_GD (t4=typedVariableList[true, "object"]) (gd1=goalDesc))
    -> exists_test(typed_terms={$t4.varmap},cond={$gd1.st})
  | ^(FORALL_GD (t5=typedVariableList[true, "object"]) (gd2=goalDesc))
    -> forall_test(typed_terms={$t5.varmap},cond={$gd2.st})
  ;

/* This rule is complicated because we have to get the names of the parameters
 * for each predicate test, which were specified back when the predicates were
 * defined. I store these in a HashMap from predicate name to ordered list of
 * parameter names. So in here, I have to look up the right list using the
 * predicate name, then iterate through that list simultaneously with the list
 * of variable names presented here and build up a list of pairs (parameter
 * name, variable) to pass into the template.
 * In addition, in order not to get name collisions with the various predicates
 * in a single production, I have to add a unique suffix to the predicate's
 * identifier. This suffix is in the scope of actionDefBody.
 */
atomicTermFormulaTest
@init {
  List params=null; 
  List<Pair> pv = new ArrayList<Pair>(); 
  int c=0;
  $actionDefBody::id_suffix++; // increment the identifier suffix for every predicate
}
  : ^(PRED_HEAD (p=predicate {params=(List)pred_params.get($p.st.toString());}) 
                (t=term {pv.add(new Pair(params.get(c),$t.st.toString())); c++;})*
     )
    -> atomic_predicate_test(predname={$p.st.toString()}, param_vals={pv}, suff={$actionDefBody::id_suffix})
  | ^(EQUALS term term) // XXX: What to do here?
  ;

atomicTermFormulaEffect 
  : ^(PRED_HEAD predicate term*)
  ;

term 
  : NAME -> {%{$NAME.text.replaceAll("-","__")}}
  | var -> {$st=$var.st;}
  ;

effect
	: ^(AND_EFFECT cEffect*)
  | cEffect
	;

cEffect
	: ^(FORALL_EFFECT typedVariableList[true, "object"] effect)
 	| ^(WHEN_EFFECT goalDesc effect)
	| pEffect
	;

pEffect
  : ^(NOT_EFFECT e1=atomicTermFormulaEffect)
  | e2=atomicTermFormulaEffect
  ;
	
/************* PROBLEMS ****************************/

problem
  : ^(PROBLEM problemDecl problemDomain requireDef? objectDecl? init goal) ;

problemDecl
  : ^(PROBLEM_NAME NAME) ;

problemDomain
  : ^(PROBLEM_DOMAIN NAME) ;

objectDecl
  : ^(OBJECTS typedNameList[true]) ;

init
  : ^(INIT initEl*) ;

initEl
	: nameLiteral ;

nameLiteral
	: atomicNameFormula ;

atomicNameFormula
	: ^(PRED_INST predicate NAME*) ;

goal : ^(GOAL goalDesc) ;
