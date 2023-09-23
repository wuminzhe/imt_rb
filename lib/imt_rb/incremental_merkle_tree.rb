require "keccak256"
require_relative "helper"

module ImtRb
  class IncrementalMerkleTree
    include ImtRb::Helper

    TREE_DEPTH = 32
    MAX_LEAVES = 2**TREE_DEPTH
    EMPTY_LEAF = "\x00" * 32 # == to_binary("0000000000000000000000000000000000000000000000000000000000000000")

    ZERO_VALUES = [
      to_binary("0000000000000000000000000000000000000000000000000000000000000000"), # EMPTY_LEAF
      to_binary("ad3228b676f7d3cd4284a5443f17f1962b36e491b30a40b2405849e597ba5fb5"),
      to_binary("b4c11951957c6f8f642c4af61cd6b24640fec6dc7fc607ee8206a99e92410d30"),
      to_binary("21ddb9a356815c3fac1026b6dec5df3124afbadb485c9ba5a3e3398a04b7ba85"),
      to_binary("e58769b32a1beaf1ea27375a44095a0d1fb664ce2dd358e7fcbfb78c26a19344"),
      to_binary("0eb01ebfc9ed27500cd4dfc979272d1f0913cc9f66540d7e8005811109e1cf2d"),
      to_binary("887c22bd8750d34016ac3c66b5ff102dacdd73f6b014e710b51e8022af9a1968"),
      to_binary("ffd70157e48063fc33c97a050f7f640233bf646cc98d9524c6b92bcf3ab56f83"),
      to_binary("9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af"),
      to_binary("cefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0"),
      to_binary("f9dc3e7fe016e050eff260334f18a5d4fe391d82092319f5964f2e2eb7c1c3a5"),
      to_binary("f8b13a49e282f609c317a833fb8d976d11517c571d1221a265d25af778ecf892"),
      to_binary("3490c6ceeb450aecdc82e28293031d10c7d73bf85e57bf041a97360aa2c5d99c"),
      to_binary("c1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb"),
      to_binary("5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc"),
      to_binary("da7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2"),
      to_binary("2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f"),
      to_binary("e1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a"),
      to_binary("5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0"),
      to_binary("b46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0"),
      to_binary("c65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2"),
      to_binary("f4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9"),
      to_binary("5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377"),
      to_binary("4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652"),
      to_binary("cdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef"),
      to_binary("0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d"),
      to_binary("b8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0"),
      to_binary("838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e"),
      to_binary("662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e"),
      to_binary("388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322"),
      to_binary("93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735"),
      to_binary("8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9")
    ].freeze

    attr_reader :tree

    def initialize
      @tree = {
        branch: Array.new(TREE_DEPTH) { EMPTY_LEAF }, # 初始化为零值
        count: 0
      }
    end

    # leaf: binary
    def append(leaf)
      raise "Merkle tree is full" if @tree[:count] >= MAX_LEAVES

      @tree[:count] += 1
      size = @tree[:count]
      (0...TREE_DEPTH).each do |level|
        if size & 1 == 1
          @tree[:branch][level] = leaf
          return
        end
        leaf = digest(@tree[:branch][level] + leaf)
        size /= 2
      end

      raise "unreachable"
    end

    def root
      hash = ZERO_VALUES[0]
      (0...TREE_DEPTH).each do |level|
        ith_bit = (@tree[:count] >> level) & 0x01
        the_next = @tree[:branch][level]

        hash =
          if ith_bit == 1
            digest(the_next + hash)
          else
            digest(hash + ZERO_VALUES[level])
          end
      end
      hash
    end

    def root_hex
      to_hex(root)
    end
  end
end

# # example
# tree = ImtRb::IncrementalMerkleTree.new
# leaf = ImtRb::IncrementalMerkleTree.to_binary("0000000000000000000000000000000000000000000000000000000000000001")
# tree.append(leaf)
# p tree.root_hex == "21db8421fb719c4d28af3cda6aeee3388f75e2cc467bfc7b950d32a425f7d355"
