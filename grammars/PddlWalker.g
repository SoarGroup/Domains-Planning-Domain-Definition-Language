tree grammar PddlWalker;

options {
	tokenVocab = Pddl;
	ASTLabelType=CommonTree;
	output=template;
}

@members {
    List predicate_names = new ArrayList();
    List object_types = new ArrayList();
    //List<Pair> object_types = new ArrayList<Pair>();
}

pddlDoc : domain -> {$st = $domain.st;}
        | problem -> {$st = $problem.st;}
        ;

/************* DOMAINS ****************************/

domain
    : ^(DOMAIN domainName requireDef? typesDef?
                constantsDef? predicatesDef? (effects+=structureDef)*)
      -> domain(name={$domainName.st}, predicate_names={predicate_names}, predicatedefs={$predicatesDef.st}, actiondefs={$effects})
    ;

domainName
    : ^(DOMAIN_NAME NAME) -> {%{$NAME.text.replaceAll("-","__")}} ;

requireDef
    : ^(REQUIREMENTS REQUIRE_KEY+)
    ;

typesDef returns [List types]
@init {
  $types = new ArrayList();
}
	: ^(TYPES (NAME {$types.add($NAME.text.replaceAll("-","__"));})+) 
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
	: ^(PREDICATES (p+=atomicFormulaSkeleton)+) -> template(list={$p})
<<
<list;separator="\n\n">
>> ;

atomicFormulaSkeleton
	: ^(predicate (v=typedVariableList)?)
	  {predicate_names.add($predicate.st.toString());} -> predicate_def(name={$predicate.st.toString()},params={$v.varmap}) 
	;

predicate : NAME -> {%{$NAME.text.replaceAll("-","__")}};

typedVariableList returns [List varmap] 
    @init {$varmap=new ArrayList();} 
    : (v=singleTypeVar {$varmap.add(new Pair($v.n,$v.t));})+
    ;

singleTypeVar returns [String n, String t]
    : ^(VAR NAME type) {$n=$NAME.text.replaceAll("-","__");$t=($type.st!=null?$type.st.toString():"object");} ;

structureDef : actionDef {$st=$actionDef.st;} ;

var	: ^(VAR NAME) -> {%{$NAME.text.replaceAll("-","__")}} ;

/************* ACTIONS ****************************/

actionDef
    : ^(ACTION actionSymbol (vars=typedVariableList)? actionDefBody)
      -> action(name={$actionSymbol.st.toString()}, params={$vars.varmap}, body={$actionDefBody.st})
    ;

actionSymbol : NAME -> {%{$NAME.text.replaceAll("-","__")}};


actionDefBody
	: ^(PRECONDITION goalDesc?) ^(EFFECT effect?) -> action_body(preconds={$goalDesc.st}, effects={$effect.st})
	;


goalDesc
	: (t=atomicTermFormulaTest) {$st=$t.st;}
	| ^(AND_GD (t1+=goalDesc)*) -> and_gd(terms={$t1})
	| ^(OR_GD (t2+=goalDesc)*) -> or_gd(terms={$t2})
	| ^(NOT_GD (t3=goalDesc)) -> not_gd(term={$t3.st})
	| ^(IMPLY_GD (a=goalDesc) (c=goalDesc)) -> imply_gd(ant={$a.st}, cons={$c.st})
	| ^(EXISTS_GD (t4=typedVariableList) (c1=goalDesc)) -> exists_gd(typed_terms={$t4.varmap}, cond={$c1.st})
	| ^(FORALL_GD (t5=typedVariableList) (c2=goalDesc)) -> forall_gd(typed_terms={$t5.varmap}, cond={$c2.st})
    ;

atomicTermFormulaTest
	: ^(PRED_HEAD predicate (t+=term)*) 
	  -> atomic_predicate_test(predname={$predicate.st.toString()}, terms={$t})
  | ^(EQUALS (t1=term) (t2=term))
    -> equality(t1={$t1.st}, t2={$t2.st})
	;

atomicTermFormulaEffect returns [String predname, List terms]
	: ^(PRED_HEAD predicate (t+=term)*) {$predname=$predicate.st.toString(); $terms=$t;}
	;

term 
     : NAME -> {%{$NAME.text.replaceAll("-","__")}}
     | var -> {$st=$var.st;}
     ;

effect
	: ^(AND_EFFECT (e+=cEffect)+) -> and_effect(effects={$e})
	| cEffect {$st=$cEffect.st;}
	;

cEffect
  : ^(FORALL_EFFECT (vl=typedVariableList) effect) -> forall_effect(typed_terms={$vl.varmap}, effect={$effect.st})
  | ^(WHEN_EFFECT goalDesc effect) -> when_effect(cond={$goalDesc.st}, effect={$effect.st})
  | pEffect {$st=$pEffect.st;}
  ;

pEffect
	: ^(NOT_EFFECT e1=atomicTermFormulaEffect) -> remove_predicate_effect(predname={$e1.predname},terms={$e1.terms})
	| e2=atomicTermFormulaEffect -> add_predicate_effect(predname={$e2.predname},terms={$e2.terms})
	;
	
/************* PROBLEMS ****************************/

problem
	: ^(PROBLEM problemDecl problemDomain requireDef? objectDecl?
      		init goal)
      -> problem(name={$problemDecl.st}, domain={$problemDomain.st}, init_func={$init.st})
    ;

problemDecl
    : ^(PROBLEM_NAME NAME) -> {%{$NAME.text.replaceAll("-","__")}}
    ;

problemDomain
	: ^(PROBLEM_DOMAIN NAME) -> {%{$NAME.text.replaceAll("-","__")}}
	;

objectDecl
	: ^(OBJECTS typedNameList[true])
	;

init
	: ^(INIT (e+=initEl)*)
	-> init(objects={object_types}, init_preds={$e})
	;

initEl
	: nameLiteral {$st=$nameLiteral.st;}
	;

nameLiteral
	: atomicNameFormula {$st=$atomicNameFormula.st;}
	;

atomicNameFormula
@init {
  List t = new ArrayList();
}
	: ^(PRED_INST predicate (NAME {t.add($NAME.text.replaceAll("-","__"));})*)
	-> init_predicate(name={$predicate.st},terms={t})
	;

// Should allow preGD instead of goalDesc -
// but I can't get the LL(*) parsing to work
// This means 'preference' preconditions cannot be used
//goal : '(' ':goal' preGD ')'  -> ^(GOAL preGD);
goal : ^(GOAL goalDesc) ;
