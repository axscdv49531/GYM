package tw.gym.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import tw.gym.model.ClassBean;
import tw.gym.repository.ClassRepository;

@Transactional
@Service
public class testaaa {

    @Autowired
    ClassRepository claRepo;

    // public List<ClassBean> findd(String className) {
    // Specification<ClassBean> spec = new Specification<ClassBean>() {
    //
    // @Override
    // public Predicate toPredicate(Root<ClassBean> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
    // List<Predicate> predicates = new ArrayList<>();
    // Path<Object> cName = root.get("className");
    // // Predicate nameSearch = cb.equal(cName, "test1129");
    // Predicate nameSearch = cb.like(cName.as(String.class), "%" + className + "%");
    // predicates.add(nameSearch);
    // Predicate and = cb.and(predicates.toArray(new Predicate[predicates.size()]));
    // return and;
    // }
    //
    // };
    // List<ClassBean> cBean = claRepo.findAll(spec);
    // System.out.println(cBean);
    // return cBean;
    //
    // }

    public List<ClassBean> findddd(String a, String pr, String sd, String ed) {
        System.out.println(a);
        System.out.println(pr);
        System.out.println(sd);
        System.out.println(ed);
    // // SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    // // java.util.Date d = null;
    // // d = format.parse(sd);
    // // java.sql.Date sdate = new java.sql.Date(d.getTime());
    // // java.util.Date e = null;
    // // e = format.parse(ed);
    // // java.sql.Date edate = new java.sql.Date(e.getTime());
        Specification<ClassBean> spec = new Specification<ClassBean>() {

            @Override
            public Predicate toPredicate(Root<ClassBean> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Path<Object> cName = root.get("className");
                Path<Object> cPrice = root.get("classPrice");
                List<Predicate> predicates = new ArrayList<>();

                if (a != null && !a.isEmpty()) {
                    Predicate nameSearch = cb.like(cName.as(String.class), a + "%");
                    predicates.add(nameSearch);
                }
                if (pr != null && !pr.isEmpty()) {
                    Predicate priceSearch = cb.equal(cPrice, pr);
                    predicates.add(priceSearch);
                }
                if (sd != null && !sd.isEmpty() && ed != null && !ed.isEmpty()) {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date d = null;
                    try {
                        d = format.parse(sd);
                    } catch (ParseException e2) {
                        e2.printStackTrace();
                    }
                    java.sql.Date sdate = new java.sql.Date(d.getTime());
                    java.util.Date e = null;
                    try {
                        e = format.parse(ed);
                    } catch (ParseException e1) {
                        e1.printStackTrace();
                    }
                    java.sql.Date edate = new java.sql.Date(e.getTime());
                    Predicate dateSearch = cb.between(root.get("classDate"), sdate, edate);
                    predicates.add(dateSearch);
                }

                // Predicate and = cb.and(nameSearch, dateSearch, priceSearch);
                Predicate and = cb.and(predicates.toArray(new Predicate[predicates.size()]));
                return and;
            }

        };
        // Sort sort = Sort.by(Sort.Direction.ASC, "classDate");
        List<ClassBean> cBean = claRepo.findAll(spec);
        return cBean;

    }

}
