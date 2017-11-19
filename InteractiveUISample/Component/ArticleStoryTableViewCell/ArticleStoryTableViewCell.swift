//
//  ArticleStoryTableViewCell.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/18.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class ArticleStoryTableViewCell: UITableViewCell {

    //UI部品の配置
    @IBOutlet weak private var articleStoryImageWrappedView: UIView!
    @IBOutlet weak private var articleStoryButtonWrappedView: UIView!
    @IBOutlet weak private var articleStoryButton: UIButton!

    //ViewControllerへ処理内容を引き渡すためのクロージャー
    var showStoryAction: (() -> ())?

    //MARK: - Initializer

    override func awakeFromNib() {
        super.awakeFromNib()

        setupArticleStoryTableViewCell()
    }

    //MARK: - Private Function

    //入力ボタンを押したタイミングで実行される処理
    @objc private func onDownArticleStoryButton(sender: UIButton) {
        UIView.animate(withDuration: 0.06, animations: {
            self.articleStoryButtonWrappedView.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: nil)
    }

    //入力ボタンを押して離したタイミングで実行される処理
    @objc private func onUpArticleStoryButton(sender: UIButton) {
        UIView.animate(withDuration: 0.06, animations: {
            self.articleStoryButtonWrappedView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { finished in
            
            //ViewController側でクロージャー内に設定した処理を実行する
            self.showStoryAction?()
        })
    }

    private func setupArticleStoryTableViewCell() {

        //セルの装飾設定をする
        self.accessoryType  = .none
        self.selectionStyle = .none

        //写真付きサムネイル枠の装飾設定
        articleStoryImageWrappedView.layer.masksToBounds = false
        articleStoryImageWrappedView.layer.cornerRadius = 5.0
        articleStoryImageWrappedView.layer.borderColor = UIColor.init(code: "dddddd").cgColor
        articleStoryImageWrappedView.layer.borderWidth = 1
        articleStoryImageWrappedView.layer.shadowRadius = 2.0
        articleStoryImageWrappedView.layer.shadowOpacity = 0.15
        articleStoryImageWrappedView.layer.shadowOffset = CGSize(width: 0, height: 1)
        articleStoryImageWrappedView.layer.shadowColor = UIColor.black.cgColor

        //ボタンアクションに関する設定
        //TouchUp・TouchDownの時のイベントを設定する（完了時の具体的な処理はTouchUp側で設定すること）
        articleStoryButton.addTarget(self, action: #selector(self.onDownArticleStoryButton(sender:)), for: .touchDown)
        articleStoryButton.addTarget(self, action: #selector(self.onUpArticleStoryButton(sender:)), for: [.touchUpInside, .touchUpOutside])
    }
}