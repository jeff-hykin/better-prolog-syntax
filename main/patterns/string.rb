# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")

export = Grammar.new_exportable_grammar
export.external_repos = [] # patterns that are imported
export.exports = [ # patterns that are exported
    :string,
]
# (other :patterns can be created and used, but they will be namespace-randomized to keep them from ever conflicting/overwriting external patterns)

fancy_hex_escape = Pattern.new(
    match: /\\x[abcdefABCDEF0-9]+\\/,
    tag_as: "constant.character.escape.hex"
)
unicode_escape = Pattern.new(
    match: /\\u....|\\U......../,
    tag_as: "constant.character.escape.unicode"
)
escape_pattern = Pattern.new(
    match: /\\\\|\\'|\\"|\"|\\a|\\b|\\c|\\e|\\f|\\n|\\r|\\s|\\t|\\v|\\\n/,
    tag_as: "constant.character.escape"
)
# TODO: octal: https://www.swi-prolog.org/man/syntax.html

export[:string_double_quote] = PatternRange.new(
    tag_as: "string.quoted.double",
    start_pattern: Pattern.new(
        match: /"/,
        tag_as: "string.quoted"
    ),
    end_pattern: Pattern.new(
        match: /"/,
        tag_as: "string.quoted"
    ),
    includes: [
        fancy_hex_escape,
        unicode_escape,
        escape_pattern,
    ],
)

export[:string_single_quote] = PatternRange.new(
    tag_as: "string.quoted.single",
    start_pattern: Pattern.new(
        match: /'/,
        tag_as: "string.quoted"
    ),
    end_pattern: Pattern.new(
        match: /'/,
        tag_as: "string.quoted"
    ),
    includes: [
        fancy_hex_escape,
        unicode_escape,
        escape_pattern,
    ],
)

export[:string] = [
    :string_double_quote,
    :string_single_quote,
]