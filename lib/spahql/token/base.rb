module Spah
  module SpahQL
    module Token
      
      # Detects a token of any type and returns the resume index and the found token, along with the type of token encountered.
      # @param [Numeric] i The index at which to detect the token
      # @param [String] query The string query
      # @return [Hash, nil] A hash with keys :resume_at, :token, :token_type, or nil.
      def self.parse_at(i, query)
        r = nil
        [ 
          Spah::SpahQL::Token::ComparisonOperator,
          Spah::SpahQL::Token::String,
          Spah::SpahQL::Token::Numeric,
          Spah::SpahQL::Token::Boolean,
          Spah::SpahQL::Token::Set,
          Spah::SpahQL::Token::SelectionQuery
        ].each do |klass|
          res = klass.parse_at(i, query)
          return res unless res.nil?
        end
        return nil
      end
      
      # A superclass wrapping all tokens that may be generated by the query parser during parsing.
      # All subclasses are expected to implement a class method parse_at(index, string) which
      # reads ahead and identifies the token, returning a tuple of the terminating index for the found token
      # and the token itself, or nil if the token was not identified at the given index.
      class Base
        
        # Never ever use this. You did not see this.
        def self.parse_at(i, query)
          raise "override me"
        end
        
      end
      
    end
  end
end