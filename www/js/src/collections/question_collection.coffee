define(["backbone", "models/Question"], (Backbone, Question) ->
  class QuestionCollection extends Backbone.Collection
    model: Question

  return QuestionCollection
)