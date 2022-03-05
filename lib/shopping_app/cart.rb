require_relative "item_manager"
require_relative "ownable"

class Cart
  include ItemManager
  include Ownable

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    return if owner.wallet.balance < total_amount
    puts "---------------------------------------------------------"

  # ## 要件
  #   - カートの中身（Cart#items）のすべてのアイテムの購入金額が、カートのオーナーのウォレットからアイテムのオーナーのウォレットに移されること
  #   - カートの中身（Cart#items）のすべてのアイテムのオーナー権限が、カートのオーナーに移されること。
  #   - カートの中身（Cart#items）が空になること。→ 格納される値をから配列にする

  puts "実行テスト" # 購入を確定しますか?(2回目のyesを押すとcheckoutメソッドが呼ばれる)

  # アイテムオーナーの財布の残高を取得したい
  puts "---------------------------------------------------------"

  # ## ヒント
  #   - アイテムのオーナーのウォレット ==> item.owner.wallet
  # 取得したい情報は DICストアのウォレット残高
  # puts item.owner.wallet; # name error
  # puts @items; # #<Item:0x00007ff19f04eb90>
  # puts @items.owner; # `check_out': undefined method `owner'
  # puts items; #<Item:0x00007ffe2e1cac80>
  # puts items.owner; # `check_out' : undefined method `owner'


  #   - カートのオーナーのウォレット ==> self.owner.wallet
  # puts self.owner.wallet.balance # 購入者の金額は取得ができた selfがなくても取得可能
  # puts self.owner.wallet Wallet instanceの取得に成功 😱👛 aaaのウォレット残高: 1000000000000

  #   - お金が移されるということ ==> (？)のウォレットからその分を引き出して、(？)のウォレットにその分を入金するということ
  #  self.owner.wallet から　引き出して(withdraw(total_amount))　item.owner.walletへ入金（deposit(total_aomount)）
  #   - アイテムのオーナー権限がカートのオーナーに移されること ==> オーナーの書き換え(item.owner = ?)
  # item.owner = self.ownerと記載すれば権限が変わるはず そもそも item の情報を取れていないので、後ほど検証
  end

end
