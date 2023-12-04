# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://172.19.154.51:3000', "http://localhost:3000", "http://localhost:3003"
    # Otros parámetros de configuración CORS
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
