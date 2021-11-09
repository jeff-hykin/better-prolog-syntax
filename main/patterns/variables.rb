# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")


# 
# 
# import/export
# 
# 
export = Grammar.new_exportable_grammar
export.external_repos = [ # patterns that are imported
    
]
export.exports = [ # patterns that are exported
    :variables,
]
# (other :patterns can be created and used, but they will be namespace-randomized to keep them from ever conflicting/overwriting external patterns)


# 
# helpers
# 
part_of_a_identifier = /[a-zA-Z_][a-zA-Z_0-9]*/
# this is really useful for keywords. eg: identifierBounds[/new/] wont match "newThing" or "thingnew"
identifierBounds = ->(regex_pattern) do
    lookBehindToAvoid(@standard_character).then(regex_pattern).lookAheadToAvoid(@standard_character)
end
identifier = identifierBounds[part_of_a_identifier]
    
    


# 
# patterns
# 
export[:special_variable] = Pattern.new(
    lookBehindToAvoid(@standard_character).then(
        match: /_/,
        tag_as: "variable.language.self.anonymous",
    ).lookAheadToAvoid(@standard_character)
)
export[:singleton_variable] = Pattern.new(
    match: identifierBounds[ /(?:__|_[A-Z])[a-zA-Z0-9_]*/ ],
    tag_as: "variable.other.singleton",
)
export[:normal_variable] = Pattern.new(
    match: identifierBounds[ /(?:[A-Z]|_)[a-zA-Z0-9_]*/ ],
    tag_as: "variable.other",
)


# 
# group them by priority
# 
export[:variables] = [
    :special_variable,
    :singleton_variable,
    :normal_variable,
]