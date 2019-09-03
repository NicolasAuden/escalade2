package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.MemberDao;
import com.nicolas.ocp6.model.bean.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class ServiceMember {

    @Autowired
    MemberDao memberDao;

    @Transactional
    public Member insertNewMember(Member member) {
        return memberDao.insertNewMember(member);
    }

    @Transactional
    public void deleteMemberAccount(int memberId) {
        memberDao.deleteMemberAccount(memberId);
    }


    public boolean isEmailAvailable(String email) {
        return memberDao.findMemberByEmail(email) == null;
    }


    public boolean isNicknameAvailable(String nickname) {
        return memberDao.findMemberbyNickname(nickname) == null;
    }


}
