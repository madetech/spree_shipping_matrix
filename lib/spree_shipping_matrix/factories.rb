factory_glob = SpreeShippingMatrix::Engine.root.join('spec/factories/*_factory.rb')
Dir[factory_glob].each { |f| require f }
