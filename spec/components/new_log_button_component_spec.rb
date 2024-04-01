# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewLogButtonComponent, type: :component do
  describe 'render' do
    context 'when only a log class is provided' do
      let(:subject) { described_class.new(log_klass: PainLog).render }
      let(:class_object) { PainLog.new.decorate }

      it 'includes default button classes' do
        expect(subject).to include('<a class="add-log-button')
      end

      it 'includes the class css_name' do
        expect(subject).to include("<a class=\"add-log-button #{class_object.css_name}")
      end

      it 'uses the :get method' do
        expect(subject).to include('data-method="get')
      end

      it 'uses the basic new log path for that class' do
        expect(subject).to include('href="pain_logs/new')
      end

      it 'includes the class icon' do
        expect(subject).to include(">#{class_object.icon_name}</span>")
      end

      it 'includes the class icon_name as a title' do
        expect(subject).to include("title=\"#{class_object.icon_name}")
      end

      it 'includes the class display name as button text' do
        expect(subject).to include("<br>+#{class_object.display_name}</a>")
      end
    end

    context 'when a path is provided' do
      let(:subject) { described_class.new(log_klass: PainLog, path: 'foo').render }

      it 'uses the provided path' do
        expect(subject).to include('href="foo')
      end
    end

    context 'when text is provided' do
      let(:subject) { described_class.new(log_klass: PainLog, text: 'foo').render }

      it 'uses the provided text' do
        expect(subject).to include('<br>+foo</a>')
      end
    end

    context 'when a method is provided' do
      let(:subject) { described_class.new(log_klass: PainLog, method: :post).render }

      it 'uses the provided method' do
        expect(subject).to include('data-method="post')
      end
    end
  end
end
