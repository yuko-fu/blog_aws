require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task_task_name', with: 'yarukoto'
        fill_in 'task_content', with: 'kontento'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        click_on 'commit'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'yarukoto'
        expect(page).to have_content 'kontento'
      end
    end
  end
  
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, task_name: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
      end
    end
    
    context 'タスクが作成日時の降順に並んでいる場合' do
      before do
        Task.create(task_name: "name1", content: "content1", created_at: Time.zone.now)
        Task.create(task_name: "name2", content: "content2", created_at: 1.day.from_now)
        Task.create(task_name: "name3", content: "content3", created_at: 1.day.ago)
      end
      it '新しいタスクが一番上に表示される' do
          visit tasks_path
          task_list = all('.task_row')
            expect(task_list.first).to have_content "name2"
      end
    end

    context 'タスクが終了期限順に並んでいる場合' do
      before do
        Task.create(task_name: "name1", content: "content1", end_date: '2023-6-30')
        Task.create(task_name: "name2", content: "content2", end_date: '2023-6-28')
        Task.create(task_name: "name3", content: "content3", end_date: '2023-7-5')
      end
      it '期限が近いタスクが一番上に表示される' do
        visit tasks_path
        click_on "終了期限でソートする"
        sleep(1)
        task_list = all('.task_row')
        expect(task_list.first).to have_content "name2"
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path
        
      end
    end
  end
end