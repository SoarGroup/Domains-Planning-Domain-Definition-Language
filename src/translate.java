/***
 * Excerpted from "The Definitive ANTLR Reference",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/tpantlr for more book information.
***/
import org.antlr.runtime.*;
import org.antlr.runtime.tree.*;
import org.antlr.stringtemplate.*;
import org.antlr.stringtemplate.language.DefaultTemplateLexer;
import java.io.*;
import java.util.Map;

public class translate {
    static String output_dir = "output";
    
    public static void gen_soar(String infile) throws Exception {
        StringTemplateGroup templates = new StringTemplateGroup(new FileReader("grammars/soar.stg"), DefaultTemplateLexer.class);
        
        ANTLRInputStream input = new ANTLRInputStream(new FileInputStream(infile));
        PddlLexer lexer = new PddlLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        PddlParser parser = new PddlParser(tokens);
        PddlParser.pddlDoc_return r = parser.pddlDoc();

        CommonTree t = (CommonTree)r.getTree();
        CommonTreeNodeStream nodes = new CommonTreeNodeStream(t);
        nodes.setTokenStream(tokens);
        PddlWalkerSoar walker = new PddlWalkerSoar(nodes);
        walker.setTemplateLib(templates);
        
        PddlWalkerSoar.pddlDoc_return r2;
        
        try {
            r2 = walker.pddlDoc();
        } catch (java.util.EmptyStackException e) {
            // this isn't a domain spec
            return;
        }

        StringTemplate output = (StringTemplate)r2.getTemplate();
        String domain = output.getAttribute("domainname").toString();
        File outfile = new File(output_dir + "/" + domain + "/rules.soar");
        
        outfile.getParentFile().mkdirs();
        FileWriter w = new FileWriter(outfile);
        w.write(output.toString());
        w.close();
    }
    
    public static void gen_python(String infile) throws Exception {
        StringTemplateGroup templates = new StringTemplateGroup(new FileReader("grammars/python_sml.stg"));

        ANTLRInputStream input = new ANTLRInputStream(new FileInputStream(infile));
        PddlLexer lexer = new PddlLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        PddlParser parser = new PddlParser(tokens);
        PddlParser.pddlDoc_return r = parser.pddlDoc();

        CommonTree t = (CommonTree)r.getTree();
        CommonTreeNodeStream nodes = new CommonTreeNodeStream(t);
        nodes.setTokenStream(tokens);
        PddlWalker walker = new PddlWalker(nodes);
        walker.setTemplateLib(templates);
        PddlWalker.pddlDoc_return r2 = walker.pddlDoc();

        StringTemplate output = (StringTemplate)r2.getTemplate(); 
        
        File outfile;
        Map attrs = output.getAttributes();
        if (attrs.containsKey("domain")) {
            // it's a problem definition
            String domain = attrs.get("domain").toString();
            String problem = attrs.get("name").toString();
            outfile = new File(output_dir + "/" + domain + "/" + problem + ".py");
        } else {
            // it's a domain definition
            String domain = attrs.get("name").toString();
            outfile = new File(output_dir + "/" + domain + "/" + domain + ".py");
        }
        
        outfile.getParentFile().mkdirs();
        FileWriter w = new FileWriter(outfile);
        w.write(output.toString());
        w.close();
    }
    
    public static void main(String[] args) throws Exception {
        if (args.length < 1) {
            System.err.println("Specify PDDL input file");
            System.exit(1);
        }
        gen_soar(args[0]);
        gen_python(args[0]);
    }
}
