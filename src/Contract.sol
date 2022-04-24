// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Todo {
    struct Task {
        uint256 id;
        uint256 date;
        string content;
        string title;
        bool isDone;
        uint256 dateComplete;
    }

    mapping(uint256 => Task) public tasks;
    uint256 nextTaskId;

    event TaskCreated(
        uint256 id,
        uint256 date,
        string content,
        string title,
        bool isDone
    );

    event TaskStatusToggled(uint256 id, uint256 date, bool isDone);

    function createTask(string memory _content, string memory _title) external {
        tasks[nextTaskId] = Task(
            nextTaskId,
            block.timestamp,
            _content,
            _title,
            false,
            0
        );
        emit TaskCreated(nextTaskId, block.timestamp, _content, _title, false);
        nextTaskId++;
    }

    function getTasks() external view returns (Task[] memory) {
        Task[] memory _tasks = new Task[](nextTaskId);
        for (uint256 i = 0; i < nextTaskId; i++) {
            _tasks[i] = tasks[i];
        }
        return _tasks;
    }

    function toggleDone(uint256 id) external {
        require(tasks[id].id != 0, "task doesn't exist");
        Task storage task = tasks[id];
        task.isDone = !task.isDone;
        task.dateComplete = task.isDone ? block.timestamp : 0;
        emit TaskStatusToggled(id, block.timestamp, task.isDone);
    }
}
