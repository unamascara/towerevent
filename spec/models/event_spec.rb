require 'spec_helper'

RSpec.describe Event, :type => :model do

  let(:team){Team.create!(name:'testTeam')}
  let(:user){User.create!(name:'testUser',team:team)}
  let(:project){Project.create!(name:'testProject',team:team)}
  describe 'event for todos' do
    it 'create a event when create a todo' do
      todo=Todo.create!(body:'have a small talk',project:project)

      event = Event.first
      expect(event.body).to eq('created todo')
      expect(event.eventable).to eq(todo)
      expect(event.eventable.url).to eq('/todos/1')

    end

  end
end
