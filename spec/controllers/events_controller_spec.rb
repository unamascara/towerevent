require 'spec_helper'

RSpec.describe EventsController, :type => :feature do

  describe 'index event' do

    it 'shows event without event source' do
      todo
      visit '/events'
      expect(page).to have_selector('.event_body')
      expect(page).to have_selector('.eventable')
    end

    it 'shows event with event source' do
      comment = Comment.create!(body:'this is good',commentable:todo)
      comment.save!
      visit '/events'

      expect(page).to have_selector('.event_body')
      expect(page).to have_selector('.eventable')
      expect(page).to have_selector('.eventsource')

    end

  end

end