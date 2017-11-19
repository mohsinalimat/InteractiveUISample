//
//  MainListViewController.swift
//  InteractiveUISample
//
//  Created by 酒井文也 on 2017/11/14.
//  Copyright © 2017年 酒井文也. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {

    @IBOutlet weak var mainListTableView: UITableView!

    //適用するカスタムトランジションのクラス
    fileprivate let articleCustomTransition = ArticleCustomTransition()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainListTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: - Private Function

    //テーブルビューの初期化を行う
    private func setupMainListTableView() {
        mainListTableView.delegate   = self
        mainListTableView.dataSource = self
        mainListTableView.rowHeight  = 330
        mainListTableView.delaysContentTouches = false
        mainListTableView.registerCustomCell(MainListTableViewCell.self)
    }
}

//MARK: - UITableViewDelegate, UIScrollViewDelegate

extension MainListViewController: UITableViewDelegate, UIScrollViewDelegate {

    //MARK: - UITableViewDelegate

    //セルを表示しようとする時の動作を設定する
    /**
     * willDisplay(UITableViewDelegateのメソッド)に関して
     *
     * 参考: Cocoa API解説(macOS/iOS) tableView:willDisplayCell:forRowAtIndexPath:
     * https://goo.gl/Ykp30Q
     */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //MainListTableViewCell型へダウンキャストする
        let mainListTableViewCell = cell as! MainListTableViewCell
        
        //セル内の画像のオフセット値を変更する
        setCellImageOffset(mainListTableViewCell, indexPath: indexPath)
        
        //セルへフェードインのCoreAnimationを適用する
        setCellFadeInAnimation(mainListTableViewCell)
    }

    //MARK: - UIScrollViewDelegate

    //スクロールが検知された時に実行される処理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //パララックスをするテーブルビューの場合
        if scrollView == mainListTableView {
            for indexPath in mainListTableView.indexPathsForVisibleRows! {
                //画面に表示されているセルの画像のオフセット値を変更する
                setCellImageOffset(mainListTableView.cellForRow(at: indexPath) as! MainListTableViewCell, indexPath: indexPath)
            }
        }
    }
    
    //UITableViewCell内のオフセット値を再計算して視差効果をつける
    private func setCellImageOffset(_ cell: MainListTableViewCell, indexPath: IndexPath) {

        //MainListTableViewCellの位置関係から動かす制約の値を決定する
        let cellFrame = mainListTableView.rectForRow(at: indexPath)
        let cellFrameInTable = mainListTableView.convert(cellFrame, to: mainListTableView.superview)
        let cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
        let tableHeight = mainListTableView.bounds.size.height + cellFrameInTable.size.height
        let cellOffsetFactor = cellOffset / tableHeight

        //画面に表示されているセルの画像のオフセット値を変更する
        cell.setBackgroundOffset(cellOffsetFactor)
    }
    
    //UITableViewCellが表示されるタイミングにフェードインのアニメーションをつける
    private func setCellFadeInAnimation(_ cell: MainListTableViewCell) {

        /**
         * CoreAnimationを利用したアニメーションをセルの表示時に付与する（拡大とアルファの重ねがけ）
         *
         * 参考:【iOS Swift入門 #185】Core Animationでアニメーションの加速・減速をする
         * http://swift-studying.com/blog/swift/?p=1162
         */

        //アニメーションの作成
        let groupAnimation            = CAAnimationGroup()
        groupAnimation.fillMode       = kCAFillModeBackwards
        groupAnimation.duration       = 0.36
        groupAnimation.beginTime      = CACurrentMediaTime() + 0.08
        groupAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)

        //透過を変更するアニメーション
        let opacityAnimation       = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.00
        opacityAnimation.toValue   = 1.00

        //作成した個別のアニメーションをグループ化
        groupAnimation.animations = [opacityAnimation]

        //セルのLayerにアニメーションを追加
        cell.layer.add(groupAnimation, forKey: nil)

        //アニメーション終了後は元のサイズになるようにする
        cell.layer.transform = CATransform3DIdentity
    }
}

//MARK: - UITableViewDataSource

extension MainListViewController: UITableViewDataSource {

    //テーブルのセクション数を設定する
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //テーブルのセクションのセル数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    //表示するセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //Xibファイルを元にデータを作成する
        let cell = tableView.dequeueReusableCustomCell(with: MainListTableViewCell.self)

        //セル内に配置したボタンを押下した際に発動されるアクションの内容を入れる
        cell.showArticleAction = {

            //記事表示用の画面へ遷移する
            let storyboard = UIStoryboard(name: "Article", bundle: nil)
            let articleViewController = storyboard.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController

            //カスタムトランジションのプロトコルを適用させる
            let navigationController = UINavigationController(rootViewController: articleViewController)
            navigationController.transitioningDelegate = self
            self.present(navigationController, animated: true, completion: nil)
        }

        return cell
    }
}

//MARK: - UIViewControllerTransitioningDelegate

extension MainListViewController: UIViewControllerTransitioningDelegate {

    //進む場合のアニメーションの設定を行う
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        articleCustomTransition.presenting = true
        return articleCustomTransition
    }

    //戻る場合のアニメーションの設定を行う
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        articleCustomTransition.presenting = false
        return articleCustomTransition
    }
}