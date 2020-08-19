//
//  ViewController.swift
//  OldRooms
//
//  Created by Cathal Farrell on 18/08/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import UIKit

class RoomListVC: UIViewController {

    let store = RoomStore(rooms: testData)

    let cellIdentifier = "RoomCell"

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationController()
    }

    fileprivate func setupNavigationController() {
        self.title = "Rooms"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    fileprivate func setupCollection() {
        let roomCellNib = UINib(nibName: cellIdentifier, bundle: nil)
        self.tableView.register(roomCellNib, forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.navigationItem.rightBarButtonItem = editButtonItem
    }

    // Called when EDIT button tapped -> Enable Deletion

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }

    @IBAction func addRoom(_ sender: Any) {
        let thisRoom = Room(name: "Black Wall", capacity: 2000)
        self.store.rooms.append(thisRoom)

        let lastRow = self.store.rooms.count-1
        let lastIndexPath = IndexPath(row: lastRow, section: 0)

        DispatchQueue.main.async {
            self.tableView.insertRows(at: [lastIndexPath], with: .left)
        }
    }

    func delete(at index: IndexPath) {
        self.store.rooms.remove(at: index.row)

        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [index], with: .left)
        }
    }

    func move(from source: IndexPath, to destination: IndexPath) {
        guard let moveRoom = self.store.rooms[source.row] as Room? else { return }

        self.store.rooms.remove(at: source.row)
        self.store.rooms.insert(moveRoom, at: destination.row)

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension RoomListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(at: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let selectedRoom = self.store.rooms[indexPath.row]
        
        guard let roomDetail = storyboard.instantiateViewController(withIdentifier: "RoomDetailVC") as? RoomDetailVC else {
            return
        }
        roomDetail.room = selectedRoom
        navigationController?.pushViewController(roomDetail, animated: true)
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        move(from: sourceIndexPath, to: destinationIndexPath)
    }
}
extension RoomListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.rooms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let room = self.store.rooms[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? RoomCell else {
                print("\(indexPath.row)")
                return UITableViewCell()
        }

        cell.configureCell(room: room)

        return cell

    }
}
