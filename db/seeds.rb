# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テスト用アカウント(１つ目)
User.create([
  {
    nickname: "田中太郎", 
    email: "test01user@test.com", 
    password: "abc456",
    password_confirmation: "abc456", 
    dream: "プログラミング",
    high_id: 7,
    low_id: 4,
    housemate_id: 1,
    hobby_id: 1,
    clean_status_id: 3,
    range_with_store_id: 3
  },
  {
    nickname: "高橋次郎", 
    email: "test02user@test.com", 
    password: "abc456",
    password_confirmation: "abc456", 
    dream: "仕事の独立",
    high_id: 3,
    low_id: 6,
    housemate_id: 3,
    hobby_id: 3,
    clean_status_id: 3,
    range_with_store_id: 2
  }
])

100.times.each do |i|
  experience_tag = ExperienceTag.new(
    title: "サンプル記事 #{i}", 
    tags: "", 
    stress: "ストレスが掛かった出来事を記載してください。", 
    category_id: [1, 2, 3].sample, 
    period_id: [1, 2, 3, 4, 5, 6, 7].sample, 
    content: "解決した方法、解決するまでの手順・注意点、真似する人へのアドバイス、解決したことにより発生するストレスと対処法、などを記載してください",
    user_id: [1, 2].sample
  )
  experience_tag.save
  sleep(0.5)
end

test_params_content_1 = <<~TEXT
  <div>
    <strong>解決した方法</strong>
  </div>
  <ul>
    <li>服のセットを決めて、それ以外を使える服だったとしても手放した。</li>
    <li>手放す方法は、破れたものはゴミとして、古着として売れるなら買取に出した。</li>
  </ul>
  <div>
    <br>
    <strong>解決するまでの手順・アドバイス</strong>
  </div>
  <ul>
    <li>捨てる前に一度押し入れにしまい込んで、無くても冬を過ごせることを確認する年が必要だと思います。</li>
    <li>服が少なくなるので、当然ですが、洗濯の頻度があがります。</li>
    <li>周りの人の意見が気になる人や、仕事上見た目に気を使わないといけない場合は難しいと思います。</li>
  </ul>
  <div>
    <br>
    <strong>解決したことにより発生するストレスと対処法</strong>
  </div>
  <div>同じ見た目になりがちなので、指摘してくる人がいると面倒です。</div>
  <div>そんなときは「自分はこうしたかったんで！」と言い切るようにしています。</div>
TEXT
test_params_content_2 = <<~TEXT
  <div>
    <strong>解決した方法</strong>
  </div>
  <ul>
    <li>調理器具（フライパン、包丁、まな板など）を捨てました</li>
    <li>オーブントースター、冷蔵庫も捨てました</li>
    <li>食器も全て捨てて、紙コップと割り箸にしました</li>
    <li>電子レンジは弁当を買ってきたときように残しています</li>
  </ul>
  <div>
    <br>
    <strong>解決するまでの手順・アドバイス</strong>
  </div>
  <ul>
    <li>基本的に外食のみの人であれば問題ないと思います。</li>
    <li>ただし、食費は自炊の人に比べるとかかります。</li>
    <li>都会でスーパーやコンビニが近くにある人でなければ真似は難しいかもしれません</li>
  </ul>
  <div>
    <br>
    <strong>解決したことにより発生するストレスと対処法</strong>
  </div>
  <div>冷蔵庫も捨てたけど、季節によってはたまに不便に感じます。</div>
TEXT
test_params = [
  {
    title: "ほとんどの冬服を捨てて、冬服３セットを決めた", 
    tags: "服, 季節, 捨て方", 
    stress: "クローゼットに使わない服も含めて多く存在して邪魔だった。朝着る服を選ぶのが面倒だった。", 
    category_id: "1", 
    period_id: "6", 
    content: test_params_content_1,
    user_id: 2
  },
  {
    title: "自炊をしないと決めて、調理器具・食器を全て手放した", 
    tags: "食事, 自炊, 調理器具, 食器", 
    stress: "ほぼ自炊しない生活で食器の管理がめんどくさい＆衛生面が気になる", 
    category_id: "3", 
    period_id: "4", 
    content: test_params_content_2,
    user_id: 1
  }
]

test_params.each do |param|
  experience_tag = ExperienceTag.new(param)
  experience_tag.save
end

