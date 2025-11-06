# Postman Test Rehberi

Bu dokümantasyon, SDP Platform API'sini Postman'de test etmek için hazırlanmıştır.

## 📋 İçindekiler

1. [Ön Hazırlık](#ön-hazırlık)
2. [Base URL](#base-url)
3. [Authentication](#authentication)
4. [API Endpoint'leri](#api-endpointleri)
5. [Postman Collection](#postman-collection)

---

## 🚀 Ön Hazırlık

### 1. Rails Server'ı Başlatın

Terminal'de proje dizininde şu komutu çalıştırın:

```bash
rails server
# veya kısaca
rails s
```

Server varsayılan olarak `http://localhost:3000` adresinde çalışacaktır.

### 2. Veritabanını Hazırlayın

Eğer henüz yapmadıysanız:

```bash
rails db:create
rails db:migrate
```

**Önemli:** `api_token` field'ı için migration çalıştırıldığından emin olun. Migration dosyası `db/migrate/20251023120000_add_api_token_to_users.rb` dosyasında tanımlıdır.

### 3. Test Kullanıcısı Oluşturun

Postman'de aşağıdaki request'i kullanarak bir kullanıcı oluşturun (Authentication gerektirmez).

---

## 🌐 Base URL

Tüm endpoint'ler şu base URL'yi kullanır:

```
http://localhost:3000/api/v1
```

---

## 🔐 Authentication

### Login (Token Alma)

**Endpoint:** `POST /api/v1/sessions`

**Headers:**

```
Content-Type: application/json
```

**Body (JSON):**

```json
{
  "email": "test@example.com",
  "password": "password123"
}
```

**Response (200 OK):**

```json
{
  "message": "Login successful",
  "user": {
    "id": "uuid-here",
    "email": "test@example.com",
    "name": "Test User",
    "role": "admin"
  },
  "token": "abc123def456..."
}
```

**Postman'de Token Kullanımı:**

1. Login response'undan `token` değerini kopyalayın
2. Diğer request'lerde **Authorization** sekmesine gidin
3. **Type:** Bearer Token seçin
4. **Token:** alanına kopyaladığınız token'ı yapıştırın

**Alternatif:** Header olarak manuel ekleyin:

```
Authorization: Bearer abc123def456...
```

### Logout

**Endpoint:** `DELETE /api/v1/sessions`

**Headers:**

```
Authorization: Bearer <token>
```

**Response (200 OK):**

```json
{
  "message": "Logged out successfully"
}
```

---

## 📡 API Endpoint'leri

### 1. Users (Kullanıcılar)

#### Tüm Kullanıcıları Listele

- **Method:** `GET`
- **URL:** `/api/v1/users`
- **Auth:** Gerekli değil
- **Response:** Tüm kullanıcıların listesi

#### Kullanıcı Detayı

- **Method:** `GET`
- **URL:** `/api/v1/users/:id`
- **Auth:** Gerekli değil
- **Example:** `/api/v1/users/123e4567-e89b-12d3-a456-426614174000`

#### Kullanıcı Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/users`
- **Auth:** Gerekli değil
- **Body (JSON):**

```json
{
  "user": {
    "email": "newuser@example.com",
    "password": "password123",
    "password_confirmation": "password123",
    "name": "New User",
    "institution": "Test University",
    "role": "researcher"
  }
}
```

#### Kullanıcı Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/users/:id`
- **Auth:** Gerekli (admin veya kendi hesabı)
- **Body (JSON):**

```json
{
  "user": {
    "name": "Updated Name",
    "institution": "New University"
  }
}
```

#### Kullanıcı Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/users/:id`
- **Auth:** Gerekli

---

### 2. Scales (Ölçekler)

#### Tüm Ölçekleri Listele

- **Method:** `GET`
- **URL:** `/api/v1/scales`

#### Ölçek Detayı

- **Method:** `GET`
- **URL:** `/api/v1/scales/:id`

#### Ölçek Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/scales`
- **Auth:** Token gereklidir (admin veya creator_id ile eşleşen kullanıcı `status` ve `usage_count` gönderebilir)
- **Body (JSON):**

```json
{
  "scale": {
    "title": "Anxiety Scale",
    "description": "A scale to measure anxiety levels",
    "doi_identifier": "10.1234/example",
    "version": "1.0",
    "language": "tr",
    "category": "Psychology",
    "total_items": 20,
    "creator_id": "user-uuid-here",
    "status": "draft",
    "metadata": { "key": "value" }
  }
}
```

**Not:**

- `creator_id` **zorunludur** ve login yaptığınız kullanıcının ID'si ile eşleşmeli (admin değilseniz)
- `status` ve `usage_count` alanlarını sadece admin veya `creator_id` ile eşleşen kullanıcı gönderebilir

#### Ölçek Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/scales/:id`
- **Auth:** Token gereklidir (admin veya scale sahibi `status` ve `usage_count` güncelleyebilir)
- **Body (JSON):**

```json
{
  "scale": {
    "title": "Updated Title",
    "description": "Updated description"
  }
}
```

**Not:** `status` ve `usage_count` alanlarını sadece admin veya scale'in `creator_id`'si ile eşleşen kullanıcı güncelleyebilir.

#### Ölçek Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/scales/:id`

---

### 3. Surveys (Anketler)

#### Tüm Anketleri Listele

- **Method:** `GET`
- **URL:** `/api/v1/surveys`

#### Anket Detayı

- **Method:** `GET`
- **URL:** `/api/v1/surveys/:id`

#### Anket Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/surveys`
- **Auth:** Token gereklidir (admin veya user_id ile eşleşen kullanıcı `status` ve `response_count` gönderebilir)
- **Body (JSON):**

```json
{
  "survey": {
    "title": "Test Survey",
    "description": "A test survey",
    "scale_id": "scale-uuid-here",
    "user_id": "user-uuid-here",
    "status": "draft"
  }
}
```

**Not:**

- `user_id` **zorunludur** ve login yaptığınız kullanıcının ID'si ile eşleşmeli (admin değilseniz)
- `status` ve `response_count` alanlarını sadece admin veya `user_id` ile eşleşen kullanıcı gönderebilir

#### Anket Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/surveys/:id`

#### Anket Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/surveys/:id`

---

### 4. Responses (Yanıtlar)

#### Tüm Yanıtları Listele

- **Method:** `GET`
- **URL:** `/api/v1/responses`

#### Yanıt Detayı

- **Method:** `GET`
- **URL:** `/api/v1/responses/:id`

#### Yanıt Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/responses`
- **Body (JSON):**

```json
{
  "response": {
    "survey_id": "survey-uuid-here",
    "user_id": "user-uuid-here",
    "answers": { "q1": "answer1", "q2": "answer2" },
    "completed_at": "2024-01-01T12:00:00Z"
  }
}
```

#### Yanıt Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/responses/:id`

#### Yanıt Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/responses/:id`

---

### 5. Analyses (Analizler)

#### Tüm Analizleri Listele

- **Method:** `GET`
- **URL:** `/api/v1/analyses`

#### Analiz Detayı

- **Method:** `GET`
- **URL:** `/api/v1/analyses/:id`

#### Analiz Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/analyses`
- **Auth:** Token gereklidir (admin veya user_id ile eşleşen kullanıcı `status`, `results` ve `credit_cost` gönderebilir)
- **Body (JSON):**

```json
{
  "analysis": {
    "survey_id": "survey-uuid-here",
    "user_id": "user-uuid-here",
    "analysis_type": "descriptive",
    "parameters": { "method": "mean" },
    "status": "pending"
  }
}
```

**Not:**

- `user_id` **zorunludur** ve login yaptığınız kullanıcının ID'si ile eşleşmeli (admin değilseniz)
- `status`, `results` ve `credit_cost` alanlarını sadece admin veya `user_id` ile eşleşen kullanıcı gönderebilir

#### Analiz Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/analyses/:id`

#### Analiz Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/analyses/:id`

---

### 6. Credit Transactions (Kredi İşlemleri)

#### Tüm İşlemleri Listele

- **Method:** `GET`
- **URL:** `/api/v1/credit_transactions`

#### İşlem Detayı

- **Method:** `GET`
- **URL:** `/api/v1/credit_transactions/:id`

#### İşlem Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/credit_transactions`
- **Body (JSON):**

```json
{
  "credit_transaction": {
    "user_id": "user-uuid-here",
    "transaction_type": "purchase",
    "amount": 100,
    "description": "Credit purchase"
  }
}
```

#### İşlem Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/credit_transactions/:id`

#### İşlem Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/credit_transactions/:id`

---

### 7. Reports (Raporlar)

#### Tüm Raporları Listele

- **Method:** `GET`
- **URL:** `/api/v1/reports`

#### Rapor Detayı

- **Method:** `GET`
- **URL:** `/api/v1/reports/:id`

#### Rapor Oluştur

- **Method:** `POST`
- **URL:** `/api/v1/reports`
- **Auth:** Token gereklidir (admin veya user_id ile eşleşen kullanıcı `status` gönderebilir)
- **Body (JSON):**

```json
{
  "report": {
    "user_id": "user-uuid-here",
    "analysis_id": "analysis-uuid-here",
    "title": "Test Report",
    "content": "Report content here",
    "format": "pdf"
  }
}
```

**Not:**

- `user_id` **zorunludur** ve login yaptığınız kullanıcının ID'si ile eşleşmeli (admin değilseniz)
- `status` alanını sadece admin veya `user_id` ile eşleşen kullanıcı gönderebilir

#### Rapor Güncelle

- **Method:** `PATCH` veya `PUT`
- **URL:** `/api/v1/reports/:id`

#### Rapor Sil

- **Method:** `DELETE`
- **URL:** `/api/v1/reports/:id`

---

## 📦 Postman Collection

### Postman Collection JSON'u Oluşturma

Postman'de şu adımları izleyin:

1. **New Collection** oluşturun: "SDP Platform API"
2. Aşağıdaki endpoint'leri ekleyin:
   - Authentication → Login
   - Authentication → Logout
   - Users → List Users
   - Users → Create User
   - Users → Get User
   - Users → Update User
   - Users → Delete User
   - Scales → List Scales
   - Scales → Create Scale
   - (diğer tüm endpoint'ler...)

### Collection Variables

Postman Collection'ınızda şu variable'ları tanımlayın:

- `base_url`: `http://localhost:3000/api/v1`
- `token`: (Login'den sonra otomatik set edilecek)

**Token'ı Otomatik Set Etme:**

1. Login request'ine gidin
2. **Tests** sekmesine gidin
3. Şu kodu ekleyin:

```javascript
if (pm.response.code === 200) {
  var jsonData = pm.response.json();
  pm.collectionVariables.set("token", jsonData.token);
}
```

4. Diğer request'lerde Authorization header'ında:
   ```
   Bearer {{token}}
   ```
   şeklinde kullanın.

---

## 🧪 Test Senaryoları

### Senaryo 1: Temel CRUD İşlemleri

**Adım adım:**

1. **User oluştur** (POST /api/v1/users)

   ```json
   {
     "user": {
       "email": "testuser@example.com",
       "password": "password123",
       "password_confirmation": "password123",
       "name": "Test User",
       "institution": "Test University",
       "role": "researcher"
     }
   }
   ```

   Response'dan `id` değerini not edin (örn: `"abc-123-def-456"`)

2. **Login yap** (POST /api/v1/sessions)

   ```json
   {
     "email": "testuser@example.com",
     "password": "password123"
   }
   ```

   Response'dan `token` değerini kopyalayın ve Postman'de Bearer Token olarak ayarlayın

3. **Token ile Scale oluştur** (POST /api/v1/scales)

   - Authorization header'ında Bearer Token kullanın

   ```json
   {
     "scale": {
       "title": "My Test Scale",
       "description": "A test scale for Postman",
       "doi_identifier": "10.1234/test",
       "version": "1.0",
       "language": "tr",
       "category": "Psychology",
       "total_items": 15,
       "creator_id": "abc-123-def-456",
       "status": "draft"
     }
   }
   ```

   ⚠️ `creator_id` değeri, login yaptığınız kullanıcının ID'si ile eşleşmeli (veya admin olmalısınız)

4. **Scale'leri listele** (GET /api/v1/scales)

   - Token gerekmeyebilir

5. **Scale güncelle** (PATCH /api/v1/scales/:id)

   - Token ile, scale'in `creator_id`'si ile eşleşen kullanıcı veya admin olmalısınız

6. **Scale sil** (DELETE /api/v1/scales/:id)
   - Token ile

### Senaryo 2: İlişkili Kayıtlar

1. ✅ User oluştur
2. ✅ Login yap (token al)
3. ✅ Scale oluştur (`creator_id` = login yaptığınız kullanıcının ID'si)
4. ✅ Survey oluştur (Scale'e bağlı, `user_id` = login yaptığınız kullanıcının ID'si)
5. ✅ Response oluştur (Survey'ye bağlı)

### Senaryo 3: Authentication Testleri

1. ✅ Geçersiz email/password ile login dene → 401 Unauthorized beklenir
2. ✅ Token olmadan Scale oluşturmayı dene → `status` field'ı gönderilemez (ancak diğer field'lar çalışabilir)
3. ✅ Geçersiz token ile erişim dene → `current_user` nil olur, protected field'lar gönderilemez

---

## ⚠️ Önemli Notlar

1. **UUID Formatı:** Tüm ID'ler UUID formatındadır. Örnek: `123e4567-e89b-12d3-a456-426614174000`

2. **Enum Değerleri:**

   - User Role: `admin`, `researcher`, `participant`
   - Scale Status: `draft`, `review`, `published`, `archived`

3. **Password Requirements:** `bcrypt` kullanıldığı için password en az 3 karakter olmalıdır.

4. **CORS:** Development ortamında tüm origin'lere izin verilmiştir.

5. **Token:** Şu anda basit bir token sistemi kullanılmaktadır. Production için JWT kullanılmalıdır.

6. **Authorization:** Token olmadan da birçok endpoint çalışır, ancak bazı işlemler (özellikle `status`, `usage_count` gibi protected field'ları güncelleme) için token gereklidir. Token ile login yaptığınız kullanıcının ID'sini (`user_id` veya `creator_id`) request body'de göndermeniz gerekebilir.

---

## 🐛 Sorun Giderme

### "No route matches" Hatası

- Routes'ları kontrol edin: `rails routes`
- URL'de `/api/v1` prefix'ini unutmayın

### "ActiveRecord::RecordNotFound" Hatası

- UUID'nin doğru olduğundan emin olun
- Veritabanında kayıt olup olmadığını kontrol edin

### Authentication Hataları

- Token'ın doğru kopyalandığından emin olun
- Authorization header formatını kontrol edin: `Bearer <token>`

### CORS Hatası

- `config/initializers/cors.rb` dosyasını kontrol edin
- Server'ı restart edin

---

## 📞 Destek

Sorun yaşarsanız:

1. Rails server log'larını kontrol edin
2. `rails routes` ile route'ları listeleyin
3. `rails console` ile veritabanını kontrol edin

---

**İyi testler! 🚀**
