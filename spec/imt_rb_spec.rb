# frozen_string_literal: true

def b(str)
  [str].pack("H*")
end

RSpec.describe ImtRb do
  it "append" do
    tree = ImtRb::IncrementalMerkleTree.new

    leaf = b("0000000000000000000000000000000000000000000000000000000000000001")
    tree.append(leaf)

    expect(tree.root_hex).to eq("21db8421fb719c4d28af3cda6aeee3388f75e2cc467bfc7b950d32a425f7d355")
  end

  it "root & proof" do
    tree = ImtRb::IncrementalMerkleTree.new

    leaf0 = b("1000000000000000000000000000000000000000000000000000000000000001")
    leaf1 = b("1100000000000000000000000000000000000000000000000000000000000001")
    leaf2 = b("1110000000000000000000000000000000000000000000000000000000000001")
    tree.append(leaf0)
    tree.append(leaf1)
    tree.append(leaf2)

    # root
    expect(tree.root_hex).to eq("4bbb07248def4cdbbda3036e6fd4eef9db49dcbb4150191a01bd5f4441ad52fb")

    # proof
    proof = tree.proof
    expect(proof.size).to eq(31)
    expect(proof[0]).to eq(b("0000000000000000000000000000000000000000000000000000000000000000"))
    expect(proof[1]).to eq(b("3e26f81f95665f7bbb1ad08f706ac6a1be59715a9ce05424e3d145a703656920"))
    expect(proof[2]).to eq(b("b4c11951957c6f8f642c4af61cd6b24640fec6dc7fc607ee8206a99e92410d30"))
    expect(proof[3]).to eq(b("21ddb9a356815c3fac1026b6dec5df3124afbadb485c9ba5a3e3398a04b7ba85"))
    expect(proof[4]).to eq(b("e58769b32a1beaf1ea27375a44095a0d1fb664ce2dd358e7fcbfb78c26a19344"))
    expect(proof[5]).to eq(b("0eb01ebfc9ed27500cd4dfc979272d1f0913cc9f66540d7e8005811109e1cf2d"))
    expect(proof[6]).to eq(b("887c22bd8750d34016ac3c66b5ff102dacdd73f6b014e710b51e8022af9a1968"))
    expect(proof[7]).to eq(b("ffd70157e48063fc33c97a050f7f640233bf646cc98d9524c6b92bcf3ab56f83"))
    expect(proof[8]).to eq(b("9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af"))
    expect(proof[9]).to eq(b("cefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0"))
    expect(proof[10]).to eq(b("f9dc3e7fe016e050eff260334f18a5d4fe391d82092319f5964f2e2eb7c1c3a5"))
    expect(proof[11]).to eq(b("f8b13a49e282f609c317a833fb8d976d11517c571d1221a265d25af778ecf892"))
    expect(proof[12]).to eq(b("3490c6ceeb450aecdc82e28293031d10c7d73bf85e57bf041a97360aa2c5d99c"))
    expect(proof[13]).to eq(b("c1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb"))
    expect(proof[14]).to eq(b("5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc"))
    expect(proof[15]).to eq(b("da7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2"))
    expect(proof[16]).to eq(b("2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f"))
    expect(proof[17]).to eq(b("e1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a"))
    expect(proof[18]).to eq(b("5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0"))
    expect(proof[19]).to eq(b("b46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0"))
    expect(proof[20]).to eq(b("c65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2"))
    expect(proof[21]).to eq(b("f4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9"))
    expect(proof[22]).to eq(b("5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377"))
    expect(proof[23]).to eq(b("4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652"))
    expect(proof[24]).to eq(b("cdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef"))
    expect(proof[25]).to eq(b("0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d"))
    expect(proof[26]).to eq(b("b8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0"))
    expect(proof[27]).to eq(b("838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e"))
    expect(proof[28]).to eq(b("662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e"))
    expect(proof[29]).to eq(b("388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322"))
    expect(proof[30]).to eq(b("93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735"))
  end
end
