class RenameEncryptedPasswordToPasswordDigestInUsers < ActiveRecord::Migration[7.1]
  def change
    # 'encrypted_password' sütununu 'password_digest' olarak yeniden adlandırırız.
    # Bu, has_secure_password'ın çalışması için ZORUNLUDUR.
    rename_column :users, :encrypted_password, :password_digest
  end
end
