require 'spec_helper'

RSpec.describe Event, :type => :model do

  describe 'event for todos' do
    it 'create a event when create a todo' do

      todo
      event = Event.first
      expect(event.body).to eq('created todo')
      expect(event.eventable).to eq(todo)
      expect(event.eventable.url).to eq('/todos/1')

    end

    it 'create a event when remove a todo' do

      todo.status=3
      todo.save!
      event = Event.last
      expect(event.body).to eq('removed todo')

    end

    it 'create a event when complete a todo' do

      todo.finishes
      event = Event.last
      expect(event.body).to eq('finished todo')

    end


    it 'create a event when start a todo' do

      todo.status=1
      todo.save!
      event = Event.last
      expect(event.body).to eq('started todo')

    end

    it 'create a event when pause a todo' do

      todo.status=1
      todo.save!
      todo.status=0
      todo.save!

      event = Event.last
      expect(event.body).to eq('paused todo')

    end
    it 'create a event when assign it to a user' do

      todo.user = user
      todo.save!
      event = Event.last
      expect(event.body).to eq('assign to testUser')

    end

    it 'create a event when change the assignee' do

      todo.user = user
      todo.save!

      user2 = User.create!(name:'testUser2',team:team)
      todo.user = user2
      todo.save!

      event = Event.last
      expect(event.body).to eq('change assignee from testUser to testUser2')

    end

    it 'create a event when change the assignee' do

      todo.finishes
      todo.finished_at  = Time.now
      todo.save!
      event = Event.last
      expect(event.body).to match(%r{change finished time from})

    end

    it 'create a event when a comment is added to a todo' do

      comment = Comment.create!(body:'this is good',commentable:todo)
      comment.save!
      event = Event.last
      expect(event.body).to eq('commented Todo')

    end





  end
end
