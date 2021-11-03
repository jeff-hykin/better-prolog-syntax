# frozen_string_literal: true
require 'ruby_grammar_builder'
require 'walk_up'
require_relative walk_up_until("paths.rb")

export = Grammar.new_exportable_grammar
export.external_repos = [] # patterns that are imported
export.exports = [ # patterns that are exported
    :operators,
]

all_operators = [
    '-->',
    ':-',
    '?-',
    'dynamic',
    'discontiguous',
    'initialization',
    'meta_predicate',
    'module_transparent',
    'multifile',
    'public',
    'thread_local',
    'thread_initialization',
    'volatile',
    '|',
    ';',
    '->',
    '*->',
    ',',
    ':=',
    '\+',
    '<',
    '=',
    '=..',
    '=@=',
    '\=@=',
    '=:=',
    '=<',
    '==',
    '=\=',
    '>',
    '>=',
    '@<',
    '@=<',
    '@>',
    '@>=',
    '\=',
    '\==',
    'as',
    'is',
    '>:<',
    ':<',
    ':',
    '+',
    '-',
    '/\\',
    '\/',
    'xor',
    '?',
    '*',
    '/',
    '//',
    'div',
    'rdiv',
    '<<',
    '>>',
    'mod',
    'rem',
    '**',
    '^',
    '+',
    '-',
    '\\',
    '.',
    '$',
]

export[:basic_operators] = Pattern.new(
    match: oneOf(all_operators.select{ |each| not (each =~ /\A\w+\z/) }),
    tag_as: "keyword.operator",
)

export[:word_operators] = Pattern.new(
    lookBehindToAvoid(@standard_character).then(
        match: oneOf(all_operators.select{ |each| each =~ /\A\w+\z/ }),
        tag_as: "keyword.operator.wordlike keyword.operator",
    ).lookAheadToAvoid(@standard_character)
)

export[:assignment_operators] = Pattern.new(
    match: oneOf([
        Pattern.new(
            lookBehindToAvoid(/=/).then(
                match: /\=/,
                tag_as: "keyword.operator.assignment",
            ).lookAheadToAvoid(/=/)   
        ),
        Pattern.new(
            lookBehindToAvoid(@standard_character).then(
                match: "is",
                tag_as: "keyword.operator.wordlike keyword.operator.assignment",
            ).lookAheadToAvoid(@standard_character)
        )
    ]),
)

export[:operators] = [
    :assignment_operators,
    :word_operators,
    :basic_operators,
]