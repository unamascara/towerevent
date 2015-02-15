def team
  return if @team

  team= Team.new(name:'testTeam')
  teamuser = Teamuser.new(team:team,user:user,role:role)
  teamuser.save!
  @team=team

end

def role
  @role ||=Role.create!(name:'Admin')
end
def user
  @user ||=User.create!(name:'testUser')
end

def project
  @project ||=Project.create!(name:'testProject',team:team)
end

def todo
  @todo ||= Todo.create!(body:'have a small talk',project:project,status:0)
end
