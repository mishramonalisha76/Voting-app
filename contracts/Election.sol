pragma solidity ^0.5.0;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }
       event votedEvent (
        uint indexed _candidateId
    );

    // Read/write candidates
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public voters;
    // Store Candidates Count
    uint public candidatesCount;

    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
     
     function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender],"vote before");

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "not vote valid");

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        //trigger the event
        emit votedEvent(_candidateId);
    }
}