// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract CoursePlatform is ERC721Enumerable, Ownable {
    // Course struct
    struct Course {
        string title;
        uint256 price;
        address owner;
    }

    // Mapping from course ID to Course
    mapping(uint256 => Course) public courses;

    // Constructor
    constructor() ERC721("Course NFT", "COURSE") {}

    // Create a new course
    function createCourse(uint256 courseId, string memory title, uint256 price) external onlyOwner {
        courses[courseId] = Course(title, price, address(this));
    }

    // Buy a course
    function buyCourse(uint256 courseId) external payable {
        Course storage course = courses[courseId];
        require(course.owner != address(0), "Course does not exist");
        require(msg.value >= course.price, "Insufficient funds");

        // Transfer ownership of the course to the buyer
        _transfer(course.owner, msg.sender, courseId);
        course.owner = msg.sender;

        // Refund excess payment
        if (msg.value > course.price) {
            payable(msg.sender).transfer(msg.value - course.price);
        }
    }

    // Sell a course
    function sellCourse(uint256 courseId, uint256 price) external {
        require(_isApprovedOrOwner(msg.sender, courseId), "Not owner of course");

        courses[courseId].price = price;
    }

    // Override _beforeTokenTransfer to ensure only course owner can transfer
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal override {
        require(from == address(0) || from == courses[tokenId].owner, "Can only transfer if you own the course");
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}
