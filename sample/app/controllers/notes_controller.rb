class NotesController < ApplicationController
  def index
    if current_user != nil
      @notes = current_user.notes.all.sort(created_at:-1)
    else
      redirect_to '/auth/login'
    end
  end

  def new
    @note = NoteMod::Note.new
    form_html = render_to_string "new"
    render :json => {
      :title => "记录笔记",
      :body => form_html
    }
  end

  def create
    @note = NoteMod::Note.new(create_note_params)
    @note.creator = current_user
    if @note.save
      render :json => {
        :note_id => @note.id.to_s,
        :note_title => @note.title,
        :note_content => @note.content.html_safe,
        :note_created_at => @note.created_at.to_s,
        }
    else
      render :json => @note.errors.messages, :status => 401
    end
  end

  def edit
    @note = NoteMod::Note.find(params[:id])
    form_html = render_to_string 'edit'
    render :json => {
      :title => "修改笔记",
      :body => form_html,
      :note_title => @note.title,
      :note_content => @note.content
    }
  end

  def update
    @note = NoteMod::Note.find(params[:id])
    if @note.update_attributes(create_note_params)
      render:json => {:status=>200}
    else
      render :json => @note.errors.messages,
        :status => 401
    end

  end

  def destroy
    @note = NoteMod::Note.find(params[:id])
    @note.destroy
    render :json => {
      :msg => "删除成功"
    }
  end

private
  def create_note_params
    params.require(:note).permit(:title,:content)
  end
end
