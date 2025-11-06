class ApplicationController < ActionController::API
  # Authentication için basit token tabanlı sistem
  # Postman testleri için Authorization header'dan token okunur
  # Format: Authorization: Bearer <token>
  
  before_action :authenticate_request

  private

  def authenticate_request
    # Şimdilik authentication opsiyonel
    # İleride gerekli endpoint'ler için before_action :authenticate_user! eklenebilir
  end

  def current_user
    @current_user ||= authenticate_token
  end

  def authenticate_token
    token = extract_token_from_header
    return nil unless token
    
    # User model'inde api_token field'ı varsa onu kullan
    # Performans için sadece bir kez kontrol ediyoruz
    @user_has_api_token ||= User.column_names.include?('api_token')
    
    if @user_has_api_token
      User.find_by(api_token: token)
    else
      # Migration henüz çalıştırılmamış olabilir, nil döndür
      nil
    end
  end

  def extract_token_from_header
    auth_header = request.headers['Authorization']
    return nil unless auth_header
    
    # Bearer token formatını parse et (case-insensitive)
    # Format: "Bearer <token>" veya "bearer <token>"
    parts = auth_header.split(' ')
    if parts.length == 2 && parts.first.downcase == 'bearer'
      parts.last
    else
      nil
    end
  end
end
