# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")


export = Grammar.new_exportable_grammar
export.external_repos = [ # patterns that are imported
    
]
export.exports = [ # patterns that are exported
    :line_comment,
]
# (other :patterns can be created and used, but they will be namespace-randomized to keep them from ever conflicting/overwriting external patterns)


# 
# //comment
# 
export[:line_comment] = Pattern.new(
    match: Pattern.new(
        Pattern.new(/\s*+/).then(
            match: /%/,
            tag_as: "punctuation.definition.comment"
        ).then(
            match: /.*/,
            tag_as: "comment.line"
        )
    ),
)