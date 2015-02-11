require 'spec_helper'

RSpec.describe Event, :type => :model do

  let(:team){Team.create!(name:'testTeam')}
  let(:user){User.create!(name:'testUser',team:team)}
  let(:project){Project.create!(name:'testProject',team:team)}
  let(:todo){Todo.create!(body:'have a small talk',project:project,status:0)}
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

      todo.status=2
      todo.save!
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



  end
end
