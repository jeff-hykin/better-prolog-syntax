# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")
require_relative './tokens.rb'

# 
# 
# create grammar!
# 
# 
# grammar = Grammar.fromTmLanguage("./original.tmLanguage.json")
grammar = Grammar.new(
    name: "Prolog",
    scope_name: "source.prolog",
    fileTypes: [
        ".pl",
    ],
    version: "",
)

# 
#
# Setup Grammar
#
# 
    grammar[:$initial_context] = [
        :comments,
        :character,
        :string,
        :numeric_literal,
        :operators,
        :predicate,
        :variables,
        :symbol,
        :list,
        :paraentheses,
    ]

# 
# Helpers
# 
    part_of_a_identifier = /[a-zA-Z_][a-zA-Z_0-9]*/
    # this is really useful for keywords. eg: identifierBounds[/new/] wont match "newThing" or "thingnew"
    identifierBounds = ->(regex_pattern) do
        lookBehindToAvoid(@standard_character).then(regex_pattern).lookAheadToAvoid(@standard_character)
    end
    identifier = identifierBounds[part_of_a_identifier]
    
# 
# basic patterns
# 
    grammar[:symbol] = Pattern.new(
        should_fully_match: [ "initialize", "initialize/2", ],
        # regexp is just for default coloring
        tag_as: "constant.language.symbol punctuation.section.regexp",
        match: Pattern.new(
            Pattern.new(
                identifierBounds[ /[a-z][a-zA-Z0-9_]*/ ]
            ).maybe(
                match: /\/\d+/,
                tag_as: "keyword.other.unit"
            )
        ),
    )
    grammar[:paraentheses] = PatternRange.new(
        start_pattern: Pattern.new(
            match: / *+\(/,
            tag_as: "punctuation.parenthesis",
        ),
        end_pattern: Pattern.new(
            match: / *+\)/,
            tag_as: "punctuation.parenthesis",
        ),
        includes: [
            :$initial_context
        ],
    )
    
    # List
    # Function
    # Symbol
    # Assignment
    # underscore
    # is
    # punctuation
        # commas and periods
        # :-
        # !.
    
# 
# imports
# 
    grammar.import(PathFor[:pattern]["comments"])
    grammar.import(PathFor[:pattern]["variables"])
    grammar.import(PathFor[:pattern]["character"])
    grammar.import(PathFor[:pattern]["string"])
    grammar.import(PathFor[:pattern]["numeric_literal"])
    grammar.import(PathFor[:pattern]["predicate"])
    grammar.import(PathFor[:pattern]["list"])
    grammar.import(PathFor[:pattern]["operators"])

#
# Save
#
name = "prolog"
grammar.save_to(
    syntax_name: name,
    syntax_dir: "./autogenerated",
    tag_dir: "./autogenerated",
)