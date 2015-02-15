require 'spec_helper'

RSpec.describe EventsController, :type => :feature do

  describe 'index event' do

    it 'shows event without event source' do
      todo
      visit 'todos/1/start'
      visit '/events'

      user_name = find('.event_creator:first-child').text
      expect(user_name).to eq(user.name)
      expect(page).to have_selector('.event_body')
      expect(page).to have_selector('.event_body')
      expect(page).to have_selector('.eventable')
    end

    it 'shows event with event source' do
      comment = Comment.create!(body:'this is good',commentable:todo)
      comment.attachments<<Attachment.new(name:'attachment1',url:'/files/1')
      comment.attachments<<Attachment.new(name:'attachment2',url:'/files/2')
      comment.save!
      visit '/events'

      expect(page).to have_selector('.event_body')
      expect(page).to have_selector('.eventable')
      expect(page).to have_selector('.eventsource')
      expect(page).to have_selector('.eventcontext')

    end

  end

end
