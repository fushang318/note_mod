class NoteModal
  #笔记模态框 用来 修改 和创建 新的笔记弹出来
  constructor: (@$elm)->
    @bind_events()
    @$modal_dialog = @$elm.find('#modal-dialog')
    @$modal_body = @$elm.find('.modal-dialog .modal-body')

  make_model_dialog_page: (title,body)->
    @$modal_dialog.find('.modal-title').html(title)
    @$modal_dialog.find('.modal-body').html(body)
    @$modal_dialog.find('.modal-body .nav').remove()

  close_model_dialog:($present_position)->
    # @$modal_dialog.modal('hide')
    # @$modal_dialog.find('.modal-header .close').click()
    $present_position.closest('.modal-dialog').find('.modal-header .close').click()

  copy_raw_note_template:(copyed_area,copy_into_area)->
    copy_note_template = @$elm.find(copyed_area).clone()
    $(copy_note_template).prependTo(copy_into_area)
    @$elm.find( copy_into_area+' .note-item:first')

  toogle_item_effect:(item)->
    item.addClass('hidden-note-template')
    item.fadeIn(1000)

  animate_item_effect:(item)->
    former_color = item.css('backgroundColor')
    item.css("backgroundColor","#D9DD77")
    item.animate({backgroundColor:  former_color})

  set_information_to_head:(head_area,title,created_at_time,id)->
    head_area.find('.col-md-2 span:last').empty()
    head_area.find('.col-md-2 span:last').text(title)
    head_area.find('.col-md-5 span:last').text(created_at_time)
    head_area.find('.hidden p').text(id)

  set_information_to_content:(content_area,content)->
    content_for_show = content.replace(/\n/g,'<br>')
    content_area.find('.col-md-12').html(content_for_show)

  remove_error_class:()->
    @$modal_body.find('.error').remove()
    @$modal_body.find('.has-error').removeClass('has-error')

  set_error_class:(msg)->
    @remove_error_class()
    if msg.status is 401
      if msg.responseJSON.title isnt undefined
        @$modal_body.find('.field .form-group.note_title').append("<p class='error help-block'>"+msg.responseJSON.title+"</p>")
        @$modal_body.find('.field .form-group.note_title').addClass("has-error")
      if msg.responseJSON.content isnt undefined
        @$modal_body.find('.field .form-group.note_content').append("<p class='error help-block'>"+msg.responseJSON.content+"</p>")
        @$modal_body.find('.field .form-group.note_content').addClass("has-error")

  bind_events: ()->
    # 添加调用模态框
    @$elm.on "click", ".note-crt", (event)=>
      $.ajax
        url: "/notes/new",
        method: "get",
        dataType: "json"
      .success (msg) =>
        @make_model_dialog_page(msg.title,msg.body)

    @$elm.on "submit", ".new-form-page form", (event)=>
      event.preventDefault()
      title        = @$modal_body.find('.note-title').val()
      content = @$modal_body.find('.note-content').val()
      $.ajax
        url: "/notes"
        method: "post"
        data:{
          'note[title]':title
          'note[content]':content
        }
      .success (msg) =>
        @close_model_dialog($(event.target))
        raw_note = @copy_raw_note_template('.hidden-note-template .note-item','.present-note-items')
        raw_note_head = raw_note.find('.row.note-item-head')
        raw_note_content = raw_note.find('.row.note-item-content')
        @set_information_to_head(raw_note_head,msg.note_title,msg.note_created_at,msg.note_id)
        @set_information_to_content(raw_note_content,msg.note_content)
        @toogle_item_effect(raw_note)
      .error (msg) =>
        @set_error_class(msg)
       
    #修改调用模态框
    @$elm.on "click", ".edit-note-btn", (event)=>
      @$editing_btn_position = $(event.target).closest('.note-item') 
      note_id = $(event.target).closest('.note-item').find('.note-item-head .hidden p').text()
      $.ajax
        url: "/notes/"+note_id+"/edit",
        method: "get",
        dataType: "json"
      .success (msg) =>
         @make_model_dialog_page(msg.title,msg.body)

    @$elm.on "submit", ".edit-form-page form", (event)=>
      event.preventDefault()
      title = @$modal_body.find('.note-title').val()
      content = @$modal_body.find('.note-content').val()
      url = @$modal_body.find('.edit-form-page form').attr('action')
      $.ajax
        url: url
        method: "patch"
        data:{
          'note[title]':title
          'note[content]':content
        }
      .success (msg) =>
        @close_model_dialog($(event.target))
        edited_note = @$editing_btn_position.closest('.note-item')
        edited_note_head = edited_note.find('.row.note-item-head')
        edited_note_content = edited_note.find('.row.note-item-content')
        #
        edited_note.find('.row.note-item-head .col-md-2 span:last').empty()
        edited_note.find('.row.note-item-head .col-md-2 span:last').text(title)
        # 
        @set_information_to_content(edited_note_content,content)
        @animate_item_effect(edited_note)
      .error (msg) =>
        @set_error_class(msg)

    # 删除的效果
    @$elm.on "click",".delete-note-btn",->
      that = this
      id = $(that).parent().parent().find('.hidden p').text()
      res =  confirm("确认删除?")
      if res == true     
        $.ajax
          url: "/notes/"+id,
          method: "delete",
          dataType: "json"
        .success (msg) ->
          $(that).closest('.note-item').fadeOut();
        
jQuery(document).on 'page:change', ->
  if (".private-note-page").length > 0
    new NoteModal $('.private-note-page')