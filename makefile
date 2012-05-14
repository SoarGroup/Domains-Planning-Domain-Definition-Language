SRC=src
ANTLR_OPTS=-fo $(SRC) -lib $(SRC)
ANTLR=antlr3 $(ANTLR_OPTS)
CLASSES=classes
JAVAC_OPTS=-d $(CLASSES) -classpath antlr-3.1.3.jar:$(SRC)
JAR=pddl_trans.jar

GRAMMARS=Pddl.g PddlWalker.g PddlWalkerSoar.g
GEN_SRC=$(addprefix $(SRC)/,$(GRAMMARS:.g=.java))

java: $(GEN_SRC) $(CLASSES)
	javac $(JAVAC_OPTS) $(SRC)/*.java
	jar cf $(JAR) -C $(CLASSES) .

$(CLASSES):
	mkdir $(CLASSES)

debug:
	$(ANTLR) -debug grammars/PddlWalker.g
	$(ANTLR) -debug grammars/PddlWalkerSoar.g

$(SRC)/%.java : grammars/%.g
	$(ANTLR) $<

clean:
	rm -f $(GEN_SRC) $(SRC)/*.tokens $(SRC)/PddlParser.java $(SRC)/PddlLexer.java
	rm -rf $(CLASSES)
	rm -f $(JAR)
