# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")

export = Grammar.new_exportable_grammar
export.external_repos = [] # patterns that are imported
export.exports = [ # patterns that are exported
    :character,
]
# (other :patterns can be created and used, but they will be namespace-randomized to keep them from ever conflicting/overwriting external patterns)

export[:character] = [
    # simple character
    Pattern.new(
        should_fully_match: [
            "0'1",
            "0'a",
            "0'.",
            "0'#",
            "0'?",
            "0''",
            "0'\"",
        ],
        tag_as: "constant.character.escape",
        match: Pattern.new(
            Pattern.new(
                match: /0'/,
                tag_as: "keyword.other.unit.character",
            ).then(
                match: /[^\\]/,
            )
        ),
    ),
    # special case
    Pattern.new(
        should_fully_match: [
            "0'\\\\" 
        ],
        tag_as: "constant.character.escape",
        match: Pattern.new(
            Pattern.new(
                match: /0'/,
                tag_as: "keyword.other.unit.character",
            ).then(
                match: /(?:\\\\)/,
            )
        ),
    ),
    # octal
    Pattern.new(
        should_fully_match: [
            "0'\\1",
            "0'\\123",
            "0'\\1234567012345670",
        ],
        should_not_partial_match: [
            "0'\\9999",
            "0'\\8",
            "0'\\A",
        ],
        tag_as: "constant.character.escape",
        match: Pattern.new(
            Pattern.new(
                match: /0'(?:\\)/,
                tag_as: "keyword.other.unit.octal",
            ).then(
                match: /[0-7]+/,
                tag_as: "constant.numeric.octal",
            )
        ),
    ),
    # hex
    Pattern.new(
        should_fully_match: [
            "0'\\x123",
            "0'\\x123deadbeef",
            "0'\\xdeadbeef",
            "0'\\xDEADBEEF",
            "0'\\xdeadBEEF2349",
        ],
        should_not_partial_match: [
            "0'\\xGHIJK",
            "0'\\xG",
        ],
        tag_as: "constant.character.escape",
        match: Pattern.new(
            Pattern.new(
                match: /0'(?:\\x)/,
                tag_as: "keyword.other.unit.hexadecimal",
            ).then(
                match: /[0-9a-fA-F]+/,
                tag_as: "constant.numeric.hexadecimal",
            )
        ),
    ),
    # utf-8 ?
    Pattern.new(
        should_fully_match: [
            "0'\\u1234",
        ],
        should_not_partial_match: [
            "0'\\u12A",
            "0'\\u123456",
        ],
        tag_as: "constant.character.escape",
        match: Pattern.new(
            Pattern.new(
                match: /0'(?:\\u)/,
                tag_as: "keyword.other.unit.character.unicode",
            ).then(
                match: /[0-9]{4}/,
                tag_as: "constant.numeric.unicode",
            )
        ),
    ),
    # utf-16 ?
    Pattern.new(
        should_fully_match: [
            "0'\\U00001234",
            "0'\\U99991234",
        ],
        should_not_partial_match: [
            "0'\\Udeadbeef",
            "0'\\Udead0000",
        ],
        tag_as: "constant.character.escape",
        match: Pattern.new(
            Pattern.new(
                match: /0'(?:\\U)/,
                tag_as: "keyword.other.unit.character.unicode",
            ).then(
                match: /[0-9]{8}/,
                tag_as: "constant.numeric.unicode",
            )
        ),
    ),
]