class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy,:start,:pause,:finish,:remove,:assign,:comment]

  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.all
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save

        Event.create!(creator:current_user,eventable:@todo,changed_attr:'id',new_value:@todo.id)
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end


  def start

    respond_to do |format|
      if @todo.update({status:1})
        Event.create!(creator:current_user,eventable:@todo,changed_attr:'status',new_value:1)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end


  def pause

    respond_to do |format|
      if @todo.update({status:0})
        Event.create!(creator:current_user,eventable:@todo,changed_attr:'status',new_value:0)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end



  def finish

    respond_to do |format|
      if @todo.update({status:2})
        Event.create!(creator:current_user,eventable:@todo,changed_attr:'status',new_value:2)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end



  def remove

    respond_to do |format|
      if @todo.update({status:3})
        Event.create!(creator:current_user,eventable:@todo,changed_attr:'status',new_value:3)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def assign
    new_params = params.require(:todo).permit(:user_id)
    new_user_id = new_params[:user_id]
    old_user_id = @todo.user_id.to_s
    respond_to do |format|
      if @todo.update(new_params)
        Event.create!(creator:current_user,eventable:@todo,changed_attr:'user_id',old_value:old_user_id,new_value:new_user_id) unless new_user_id==old_user_id
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end


  def comment

    comment = Comment.create!(body:'this is good',commentable:@todo)
    comment.attachments<<Attachment.new(name:'attachment1',url:'/files/1')
    comment.attachments<<Attachment.new(name:'attachment2',url:'/files/2')

    respond_to do |format|
      if comment.save
        Event.create!(creator:current_user,changed_attr:'comments',eventable:@todo,eventsource:comment)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def current_user
    User.first
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def todo_params
    ps =  params.require(:todo).permit(:body)
    ps[:project_id]=1
    ps
  end
end
