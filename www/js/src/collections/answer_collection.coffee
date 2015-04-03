define(["backbone", "models/answer"], (Backbone, Answer) ->
  class AnswerCollection extends Backbone.Collection
    model: Answer

  return AnswerCollection
)