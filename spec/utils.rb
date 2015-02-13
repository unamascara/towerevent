def team
 @team ||= Team.create!(name:'testTeam')
end

def user
  @user ||=User.create!(name:'testUser',team:team)
end

def project
  @project ||=Project.create!(name:'testProject',team:team)
end

def todo
  @todo ||= Todo.create!(body:'have a small talk',project:project,status:0)
end
