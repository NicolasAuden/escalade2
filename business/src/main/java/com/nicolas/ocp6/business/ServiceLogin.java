package com.nicolas.ocp6.business;

import com.nicolas.ocp6.consumer.contract.dao.MemberDao;
import com.nicolas.ocp6.model.bean.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Component
public class ServiceLogin {

    @Autowired
    MemberDao memberDao;

    /**
     * Récupère une liste des objets memnbers
     */
    public List<Member> getAllMembers() {
        return memberDao.findAll();
    }

    /**
     * Trouve un member en fonction de son adresse email
     */
    public Member findMemberByEmail(String inputEmail) {
        return memberDao.findMemberByEmail(inputEmail);
    }

    /**
     * check le password et l'email compatibilité
     */
    public boolean checkPassword(String inputPassword, Member member) {
        return member.getPassword().equals(inputPassword);
    }

    @Transactional
    public int updatePassword(Member member) {
        return memberDao.updatePassword(member);
    }
}
