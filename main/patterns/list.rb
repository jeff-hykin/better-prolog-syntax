# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")

export = Grammar.new_exportable_grammar
export.external_repos = [] # patterns that are imported
export.exports = [ # patterns that are exported
    :list,
]

export[:list] = PatternRange.new(
    start_pattern: Pattern.new(
        match: / *+\[/,
        tag_as: "punctuation.definition.list",
    ),
    end_pattern: Pattern.new(
        match: / *+\]/,
        tag_as: "punctuation.definition.list",
    ),
    includes: [
        :$initial_context
    ],
)