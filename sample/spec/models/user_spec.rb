require 'rails_helper'

RSpec.describe NoteMod::Note, type: :model do
  describe "笔记模块" do
    it '建立用户 tom 和笔记' do
      user_tom = create(:user)
      before_create_note_count = user_tom.notes.count
      tom_note = create(:note,:creator=>user_tom)
      after_create_note_count = user_tom.notes.count
      expect(after_create_note_count).to eq(before_create_note_count+1)
      expect(NoteMod::Note.find(tom_note).title).to eq("title a")
      expect(NoteMod::Note.find(tom_note).content).to eq("content a")
    end

    it '删除用户 tom 和笔记' do
      user_tom = create(:user)
      tom_note = create(:note,:creator=>user_tom)
      before_delete_note_count = user_tom.notes.count
      NoteMod::Note.find(tom_note).destroy
      after_delete_note_count = user_tom.notes.count
      expect(after_delete_note_count).to eq(before_delete_note_count-1)
    end
  end
end
