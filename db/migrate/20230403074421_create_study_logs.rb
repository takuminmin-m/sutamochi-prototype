class CreateStudyLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :study_logs do |t|
      t.boolean :start

      t.timestamps
    end
  end
end
