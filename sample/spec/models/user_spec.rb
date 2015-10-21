require 'rails_helper'

RSpec.describe NoteMod::Note, type: :model do
  describe "建立" do
    it '建立用户 tom 和笔记' do
      user_tom = create(:user)
      tom_note = create(:note,:creator=>user_tom)
      expect(tom_note.title).to eq("title a")
      expect(tom_note.content).to eq("content a")
    end
  end
end