module TaxwebWidgets
  class Base
    include SingletonHelper

    attr_singleton :name, 'Widget'
    attr_singleton :description

    def self.content(&block)
      define_singleton_method :content do
        block.call if block_given?
      end
    end

  end
end