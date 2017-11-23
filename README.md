# InteractiveUISample 
[ING]ライブラリを使わないでアニメーション表現を盛り込んだ機能サンプル（iOS Sample Study: Swift）

UIのスクロールやタブUIの切り替えを伴うようなコンテンツにて動きの中でポイントとなりそうな部分にアニメーション不自然にならない心地よいタイミングでに盛り込むプラクティスをするために作成したサンプルになります。

### 実装機能一覧

今回のサンプルに関しては、主に下記の3つの機能についてを実装しています。

+ UITableViewのセルが出現した際にふわっとフェードインがかかる動き
 → 特にAWAの動きを参考にした部分
+ スクロールの変化量に伴って他のView要素の位置が切り替わる動き
 → ヘッダーの動き方はReactNativeのサンプルもプラスで参考にした部分
+ UIButtonやUILabelに一工夫を加えた動き
 → 独自で実装をした部分

※ その他残りのアニメーションを伴うコンテンツ画面に関しては随時追加予定です。

### 本サンプルの画面キャプチャ

#### 画面キャプチャその1

![今回のサンプルの画面一覧その1](https://qiita-image-store.s3.amazonaws.com/0/17400/ce8aa298-ad3a-7a8d-0999-b9b5c7c99327.jpeg)

#### 画面キャプチャその2

![今回のサンプルの画面一覧その2](https://qiita-image-store.s3.amazonaws.com/0/17400/944d1fa7-2ef3-1fb2-a4c7-eca8387bdbb3.jpeg)

#### Storyboardの構成

![Storyboardの構成](https://qiita-image-store.s3.amazonaws.com/0/17400/7fc74554-715e-6848-ee1e-05920d147395.jpeg)

#### 本サンプルでの「View - Model - Presenter」構造と役割の解説

![本サンプルでの「View - Model - Presenter」構造と役割](https://qiita-image-store.s3.amazonaws.com/0/17400/e6495b31-1788-112e-752f-be200f38191f.jpeg)

### 設計の重要ポイントになる部分

#### パララックス(視差効果)表現とフェードするアニメーションを組み合わせたアニメーション実装

![パララックス(視差効果)表現とフェードするアニメーションを組み合わせたアニメーション実装](https://camo.qiitausercontent.com/634c65258dd35010ae4fe25699c97c74c86dbde7/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f65616138383737622d613862342d653436312d396465332d6136633636323531623134362e6a706567)

__動きの仕様メモ：__

1. AutoLayoutのConstraintの変更を利用した画像のパララックス(視差効果)アニメーション
2. 表示するタイミングでのセル自体のアルファ値を変更するCoreAnimation

#### スクロールの変化量に応じてヘッダー画像とナビゲーションを変化させるアニメーション実装

![スクロールの変化量に応じてヘッダー画像とナビゲーションを変化させる](https://camo.qiitausercontent.com/fdfc3f6dd3103e5f0b541467c3c6ec8c8e6dd512/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f37343665366233322d333231622d653638382d633261322d6537326133643038306666372e6a706567)

__動きの仕様メモ：__

1. コンテンツが一番上にある状態で下にスクロールをすると、ヘッダー画像が伸びるような動きをする。
2. コンテンツが一番上にある状態で上にスクロールをすると、ヘッダー画像がずれながらダミーのヘッダーが徐々に現れる。（背景のアルファ値が1に近づきながら、タイトルと戻るボタンが下から徐々に現れる）
3. ヘッダー画像が完全に隠れたら、タイトルと戻るボタンは現れたままの状態になり、更に上へスクロールを続けても位置はそのまま固定されている。

#### iPhoneXのSafeAreaの考慮と調整について

![iPhoneXのSafeAreaの考慮と調整について](https://camo.qiitausercontent.com/67cb94f05472ac138564fe8eb881fde5e96993b0/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36313736613764662d623834352d383835392d383337322d3566303431356130636235392e6a706567)

### (補足)UIScrollViewの活用

#### UIScrollViewとContainerViewを組み合わせてタブメニューUIを作成する

![UIScrollViewとContainerViewを組み合わせてタブメニューUIを作成する](https://camo.qiitausercontent.com/2285f75c05d738fe7b2f7ade89e831a4c76cd49b/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36386536636639392d313265652d633831332d613866662d3133393633363735383130372e6a706567)

#### ScrollViewを利用して複雑なレイアウトを作成する

![ScrollViewを利用して複雑なレイアウトを作成する](https://camo.qiitausercontent.com/ac54f123fa2c21b43a711009244713dcbe033576/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e616d617a6f6e6177732e636f6d2f302f31373430302f36356231326236622d653739362d343236642d343731332d3830633431306563316337312e6a706567)

### 使用ライブラリ

UIまわりの実装と直接関係のない部分に関しては、下記のライブラリを使用しました。

+ [SwiftyJSON（JSONデータの解析をしやすくする）](https://github.com/SwiftyJSON/SwiftyJSON)
+ [Alamofire（HTTPないしはHTTPSのネットワーク通信用）](https://github.com/Alamofire/Alamofire)
+ [SDWebImage（画像URLからの非同期での画像表示とキャッシュサポート）](https://github.com/rs/SDWebImage)
+ [FontAwesome.swift（「Font Awesome」アイコンの利用）](https://github.com/thii/FontAwesome.swift)

このサンプル全体の詳細解説とポイントをまとめたものは下記に掲載しております。

+ (Qiita前編) https://qiita.com/fumiyasac@github/items/d1b56ffc6d7d46c0a616 