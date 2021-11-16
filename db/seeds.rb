# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テスト用アカウント(１つ目)
user1 = User.create(
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
  }
)
# テスト用アカウント(2つ目)
user2 = User.create(
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
)
# テスト用アカウント(3つ目)
user3 = User.create(
  {
    nickname: "山下三郎", 
    email: "test03user@test.com", 
    password: "abc456",
    password_confirmation: "abc456", 
    dream: "健康",
    high_id: 2,
    low_id: 4,
    housemate_id: 3,
    hobby_id: 2,
    clean_status_id: 1,
    range_with_store_id: 2
  }
)

# タグの追加
Tag.create([
  {name: "キッチン用品"},
  {name: "食器"},
  {name: "グラス"},
  {name: "カトラリー"},
  {name: "インテリア"},
  {name: "ラグ"},
  {name: "カーテン"},
  {name: "ファブリック"},
  {name: "家具"},
  {name: "収納用品"},
  {name: "寝具"},
  {name: "バス用品"},
  {name: "トイレ用品"},
  {name: "洗面用品"},
  {name: "掃除用品"},
  {name: "洗濯用品"},
  {name: "生活雑貨"},
  {name: "防犯用品"},
  {name: "防災用品"},
  {name: "家電"},
  {name: "旅行用品"},
  {name: "仏具"},
  {name: "神具"},
  {name: "花"},
  {name: "観葉植物"},
  {name: "フラワーギフト"},
  {name: "ゴミ箱"},
  {name: "ゴミ入れ"},
  {name: "書籍"},
  {name: "洋服"},
  {name: "スーツ・ビジネスウェア"},
  {name: "フォーマルウェア"},
  {name: "パジャマ・ルームウェア"},
  {name: "水着"},
  {name: "ベビー服"},
  {name: "肌着"},
  {name: "着物"},
  {name: "着ぐるみ・コスチューム"},
  {name: "ゲーム機本体"},
  {name: "ゲームソフト"},
  {name: "CD／DVD"},
  {name: "PCソフト"},
  {name: "事務用品"},
  {name: "筆記具"},
  {name: "ノート・メモ帳"},
  {name: "ファイル・バインダー"},
  {name: "紙製品"},
  {name: "封筒・はがき・レター用品"},
  {name: "手帳・カレンダー"},
  {name: "デジタル文具"},
  {name: "オフィス家具・収納"},
  {name: "オフィス機器"},
  {name: "学用品"},
  {name: "プレゼン・会議・セミナー用品"},
  {name: "店舗・販促用品"},
  {name: "のし・冠婚葬祭用品"},
  {name: "印鑑・スタンプ"},
  {name: "ラッピング材"},
  {name: "梱包材"},
  {name: "医療・介護用家具"},
  {name: "カメラ"},
  {name: "テレビ・レコーダー"},
  {name: "オーディオ"},
  {name: "ポータブルオーディオ"},
  {name: "キッチン家電"},
  {name: "生活家電"},
  {name: "空調・季節家電"},
  {name: "照明"},
  {name: "理美容家電"},
  {name: "健康家電"},
  {name: "家電アクセサリ・サプライ"},
  {name: "携帯電話・スマートフォン"},
  {name: "カーナビ・カーAV"},
  {name: "無線・トランシーバー"},
  {name: "電話機・FAX"},
  {name: "ウェアラブルデバイス"},
  {name: "イヤホン・ヘッドホン"},
  {name: "電池"},
  {name: "スキンケア・ボディケア"},
  {name: "オーラルケア"},
  {name: "ヘアケア・カラー・スタイリング"},
  {name: "メイクアップ"},
  {name: "ネイル"},
  {name: "香水・フレグランス"},
  {name: "メイク道具・フェイスケアツール"},
  {name: "シェービング・ムダ毛処理"},
  {name: "サロン・エステ用品"},
  {name: "美容・栄養補助食品"},
  {name: "デスクトップ"},
  {name: "ノートパソコン"},
  {name: "タブレット"},
  {name: "サーバー"},
  {name: "キーボード・マウス・入力機器"},
  {name: "ディスプレイ"},
  {name: "プリンタ"},
  {name: "スキャナ"},
  {name: "データプロジェクター"},
  {name: "PCパーツ"},
  {name: "外付けドライブ・ストレージ"},
  {name: "無線LAN・ネットワーク機器"},
  {name: "ウェブカメラ・IP電話機器"},
  {name: "PCスピーカー"},
  {name: "PCアクセサリ・サプライ"},
  {name: "電子書籍リーダー"},
  {name: "電子書籍リーダーアクセサリ"},
  {name: "スマートウォッチ"},
  {name: "スマートグラス"},
  {name: "シングルボードコンピュータ・アクセサリ"},
  {name: "フィギュア・コレクタードール"},
  {name: "エアガン・モデルガン"},
  {name: "コレクションカード・アクセサリー"},
  {name: "コスプレ・仮装"},
  {name: "アニメ・萌えグッズ"},
  {name: "アイドル・芸能人グッズ"},
  {name: "食玩"},
  {name: "手芸・画材"},
  {name: "コイン・切手・ホビー収納"},
  {name: "ディスプレイケース・ディスプレイスタンド"},
  {name: "遊技機器"},
  {name: "コミュニケーションロボット"},
  {name: "ファインアート"},
  {name: "プラモデル・模型"},
  {name: "電動工具・エア工具"},
  {name: "作業工具"},
  {name: "測定工具"},
  {name: "大工道具・用品"},
  {name: "建築金物"},
  {name: "建築・住宅資材"},
  {name: "配管・排水用備品"},
  {name: "住宅用設備・製品"},
  {name: "エクステリア"},
  {name: "ガーデン"},
  {name: "塗装・壁装"},
  {name: "電設"},
  {name: "プール・屋外サウナ"},
  {name: "安全・保護用品"},
  {name: "カーナビ・カーエレクトロニクス"},
  {name: "カーアクセサリ"},
  {name: "カーセキュリティ"},
  {name: "カーパーツ"},
  {name: "カータイヤ・ホイール"},
  {name: "洗車・工具・メンテナンス用品"},
  {name: "エンジンオイル・オイルフィルター"},
  {name: "バッテリー"},
  {name: "カーキャリア・ルーフボックス"},
  {name: "ヘルメット"},
  {name: "ヘルメットパーツ・アクセサリ"},
  {name: "バイクパーツ"},
  {name: "バイクウェア・プロテクション"},
  {name: "バイクバッグ・ケース"},
  {name: "バイクアクセサリ"},
  {name: "バイクタイヤ・ホイール"},
  {name: "バイク工具・メンテナンス"},
  {name: "船舶・マリン用品"},
  {name: "オフィシャルグッズ"},
  {name: "ベビー服"},
  {name: "授乳・食事"},
  {name: "ベビーカー"},
  {name: "チャイルドシート"},
  {name: "抱っこひも・スリング"},
  {name: "おむつ・トイレ"},
  {name: "ベビーケア・バス"},
  {name: "ベビー布団・寝具"},
  {name: "ベビー家具・収納"},
  {name: "ペット用品"},
  {name: "ギター"},
  {name: "ベース"},
  {name: "ドラム・パーカッション"},
  {name: "ピアノ・キーボード"},
  {name: "弦楽器"},
  {name: "管・吹奏楽器"},
  {name: "アクセサリ"},
  {name: "PA音響機器"},
  {name: "DTM・DAW"},
  {name: "シンセサイザー・サンプラー"},
  {name: "DJ機材"},
  {name: "ステージ機器・照明"},
  {name: "カラオケ機器"},
  {name: "冷蔵庫・冷凍庫"},
  {name: "ワインセラー"},
  {name: "洗濯機・乾燥機"},
  {name: "エアコン"},
  {name: "ビルトインキッチン家電"},
  {name: "業務用厨房機器"},
  {name: "ドリンク"},
  {name: "お酒"},
  {name: "コーヒー・紅茶・お茶・粉末ドリンク"},
  {name: "スイーツ・スナック菓子"},
  {name: "米・雑穀"},
  {name: "パン・シリアル・ジャム"},
  {name: "生鮮魚介類・水産加工品"},
  {name: "卵・乳製品・チーズ"},
  {name: "レトルト・料理の素"},
  {name: "乾物"},
  {name: "製菓・製パン材料"},
  {name: "調味料・食用油・ドレッシング"},
  {name: "ベビーフード"},
  {name: "グルメギフト"},
  {name: "健康食品"},
  {name: "介護用食品"},
  {name: "捨て方アドバイス"},
  {name: "残し方アドバイス"},
  {name: "高級"},
  {name: "安価"}
])

# サンプル記事の追加
tags = Tag.all
tag_names = tags.map { |t| t.name }

users = User.all
user_ids = users.map { |u| u.id }

30.times.each do |i|
  experience_tag = ExperienceTag.new(
    title: "サンプル記事 #{i}", 
    tags: tag_names.sample(3).join('、'), 
    stress: "ストレスが掛かった出来事を記載してください。", 
    category_id: [1, 2, 3].sample, 
    period_id: [1, 2, 3, 4, 5, 6, 7].sample, 
    content: "解決した方法、解決するまでの手順・注意点、真似する人へのアドバイス、解決したことにより発生するストレスと対処法、などを記載してください",
    user_id: user_ids.sample
  )
  experience_tag.save
end

# サンプル以外の具体的な記事例を追加
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
    tags: "服、季節、捨て方", 
    stress: "クローゼットに使わない服も含めて多く存在して邪魔だった。朝着る服を選ぶのが面倒だった。", 
    category_id: "1", 
    period_id: "6", 
    content: test_params_content_1,
    user_id: user2.id
  },
  {
    title: "自炊をしないと決めて、調理器具・食器を全て手放した", 
    tags: "食事、自炊、調理器具、食器", 
    stress: "ほぼ自炊しない生活で食器の管理がめんどくさい＆衛生面が気になる", 
    category_id: "3", 
    period_id: "4", 
    content: test_params_content_2,
    user_id: user1.id
  }
]

test_params.each do |param|
  experience_tag = ExperienceTag.new(param)
  experience_tag.save
end

# いいね＆通知サンプルの追加
users = User.all
experiences = Experience.all
actions = ['いいね', '真似した']
users.each do |user|
  rand(3..10).times do
    experience = experiences.sample
    user_ids = users.map { |u| u.id }
    user_ids.delete(user.id)
    other_id = user_ids.sample
    other = users.select { |u| u.id == other_id }
    action = [0, 1].sample
    Notice.create(message: "#{other.nickname} が、あなたの記事「#{experience.title}」に「#{actions[action]}」しました" , url: "experiences/#{experience.id}", user_id: other.id)
    if action == 0
      ExperienceLike.create(like: true, imitate: false, user_id: other.id, experience_id: experience.id)
    else
      ExperienceLike.create(like: false, imitate: true, user_id: other.id, experience_id: experience.id)
    end
  end
end