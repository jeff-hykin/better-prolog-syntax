# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")

export = Grammar.new_exportable_grammar
export.external_repos = [] # patterns that are imported
export.exports = [ # patterns that are exported
    :predicate,
]

grammar[:predicate_call] = PatternRange.new(
    start_pattern: Pattern.new(
        lookBehindToAvoid(@standard_character).then(
            match: /[a-zA-Z0-9_]+/,
            tag_as: "entity.name.function.call",
        ).then(
            match: / *+\(/,
            tag_as: "punctuation.section.function.call",
        )
    ),
    end_pattern: Pattern.new(
        match: / *+\)/,
        tag_as: "punctuation.section.function.call",
    ),
    includes: [
        :$initial_context
    ],
)

grammar[:predicate_definition] = Pattern.new(
    lookBehindToAvoid(@standard_character).then(
        match: /[a-zA-Z0-9_]+/,
        tag_as: "entity.name.function.definition",
    ).then(
        match: / *+\(/,
        tag_as: "punctuation.section.function.definition",
    ).then(
        match: /.+/,
        includes: [
            :$initial_context
        ],
    ).then(
        match: /\) */,
        tag_as: "punctuation.section.function.definition",
    ).lookAheadFor(/:-/)
)

export[:predicate] = [
    :predicate_call,
    :predicate_definition,
]