# spec/decorators/todo_decorator_spec.rb
require "rails_helper"

describe Survey::ResponseDecorator do
  let(:survey_response) { Survey::Response.new.extend(Draper::Decoratable) }
  let(:decorator) { Survey::ResponseDecorator.new(survey_response) }

  describe "#display_name" do
    it "returns the name of the associated survey" do
      survey = create(:survey, name: "My Survey")
      survey_response.survey = survey

      expect(decorator.display_name).to eq("My Survey")
    end
  end

  describe "score_name" do
    it "returns the titleized name of the score range step" do
      allow(survey_response).to receive(:score_range_step).and_return(double(name: "mild symptoms", description: nil))

      expect(decorator.score_name).to eq("Mild Symptoms")
    end

    it "returns nil when there is no score range step" do
      allow(survey_response).to receive(:score_range_step).and_return(nil)

      expect(decorator.score_name).to be_nil
    end
  end

  describe "score_description" do
    it "returns the description of the score range step" do
      allow(survey_response).to receive(:score_range_step).and_return(double(name: "Mild", description: "Symptoms are mild"))

      expect(decorator.score_description).to eq("Symptoms are mild")
    end

    it "returns nil when there is no score range step" do
      allow(survey_response).to receive(:score_range_step).and_return(nil)

      expect(decorator.score_description).to be_nil
    end
  end

  describe "difference_from_previous_response" do
    it "returns nil when there is no previous response" do
      allow(survey_response).to receive(:previous_response).and_return(nil)

      expect(decorator.difference_from_previous_response).to be_nil
    end

    it "returns a no-change message when score is the same as the previous response" do
      previous = double(total_score: 10)
      allow(survey_response).to receive(:previous_response).and_return(previous)
      allow(survey_response).to receive(:total_score).and_return(10)

      expect(decorator.difference_from_previous_response).to eq("No change from previous response")
    end

    it "returns a message with a frowning emoji when score is higher than the previous response" do
      previous = double(total_score: 5)
      allow(survey_response).to receive(:previous_response).and_return(previous)
      allow(survey_response).to receive(:total_score).and_return(8)

      expect(decorator.difference_from_previous_response).to eq("+3 from previous response ☹️")
    end

    it "returns a message with a happy emoji when score is lower than the previous response" do
      previous = double(total_score: 10)
      allow(survey_response).to receive(:previous_response).and_return(previous)
      allow(survey_response).to receive(:total_score).and_return(7)

      expect(decorator.difference_from_previous_response).to eq("-3 from previous response 😀")
    end
  end
end
