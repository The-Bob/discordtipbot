require "bitcoin_rpc"

class CoinApi
  @type : String

  def initialize(@config : Config, @log : Logger)
    @log.debug("#{config.coinname_short}: Initializing Coin Interaction API for #{@config.coinname_full} with type #{@config.coin_api_type}")

    @type = @config.coin_api_type

    # For RPC communication we are using https://github.com/citizen428/bitcoin_rpc
    @rpc = BitcoinRpc.new(@config.rpc_url, @config.rpc_username, @config.rpc_password)
    @log.debug("#{config.coinname_short}: #{@rpc.getinfo}")
    # elsif @type == "blockio"
    # @blockio = Blockio::Client.new(@config.blockio_api_key)
  end

  def get_info
    @rpc.getinfo
  end

  def withdraw(address : String, amount : Float64, comment : String)
    if @type == "rpc"
      @rpc.send_to_address(address, amount, comment)
    end
  end

  def new_address
    @rpc.get_new_address
  end

  def get_received_by_address(address : String)
    @rpc.get_received_by_address(address)
  end

  def list_transactions
    @rpc.list_transactions
  end

  def validate_address(address : String)
    @rpc.validate_address(address)
  end
end
