-- 1 -- Classement des clients par nombre d'occupations--

SELECT CLI_NOM,CHB_PLN_CLI_NB_PERS 
from T_CLIENT as A,TJ_CHB_PLN_CLI as B 
where A.CLI_ID=B.CLI_ID 
order by CHB_PLN_CLI_NB_PER

--2-- Classement des clients par montant dépensé dans l'hôtel--
SELECT CLI_NOM,LIF_MONTANT from T_CLIENT as A,T_FACTURE as B,T_LIGNE_FACTURE as C where A.CLI_ID=B.CLI_ID and B.FAC_ID=C.FAC_ID order by LIF_MONTANT ;

--2-- Classement des occupations par mois--
select count(CHB_PLN_CLI_OCCUPE),strftime ('%m',PLN_JOUR) 
from TJ_CHB_PLN_CLI 
group by strftime ('%m',PLN_JOUR)

--3-- Classement des occupations par trimestre
select count(CHB_PLN_CLI_OCCUPE),(cast(strftime('%m', PLN_JOUR) as integer) + 2) / 3 as Trimestre 
from TJ_CHB_PLN_CLI 
group by (cast(strftime('%m', PLN_JOUR) as integer) + 2) / 3

--4-- Montant TTC de chaque ligne de facture (avec remise)--

--5--Tarif moyen des chambres par étage et années croissantes--
select  avg(TRF_CHB_PRIX),TRF_DATE_DEBUT 
from TJ_CHB_TRF  
order by  strftime('%y',TRF_DATE_DEBUT)

--6-- Chambre la plus chère et en quelle année--
select max(TRF_CHB_PRIX),TRF-DATE_DEBUT 
from TJ_CHB_TRF

--7-- Chambre réservées mais pas occupées--
select CHB_ID from TJ_CHB_PLN_CLI 
where CHB_PLN_CLI_RESERVE=1 and CHB_PLN_CLI_OCCUPE=0

--8-- Taux de résa par chambre--
CREATE VIEW T_CHB_RES as SELECT CHB_ID,count(CHB_ID) as megaman 
from TJ_CHB_PLN_CLI  where ( CHB_PLN_CLI_RESERVE='1') 
group by (CHB_ID)

--9-- Facture réglées avant leur édition--
select FAC_ID from T_FACTURE 
where FAC_DATE>FAC_PMT_DATE

--10-- Par qui ont été payées ces factures réglées en avance ? --
select CLI_NOM from T_CLIENT 
where CLI_ID in (select CLI_ID 
from T_FACTURE 
where FAC_DATE>FAC_PMT_DATE)

--11-- Classement des modes de paiement (par le mode et le montant total généré)--

--12-- Vous vous créez en tant que client de l'hôtel--
Insert into T_CLIENT(CLI_ID,CLI_NOM,CLI_PRENOM,CLI_ENSEIGNE,TIT_CODE) values ('22777',’SUTTERLIN’,’Sébastien’,'Ludus','2727') ; 
--13-- Ne pas oublier vos moyens de communication--

--14-- Vous créez une nouvelle chambre à la date du jour--
insert into T_CHAMBRE values ('22777','2727','3','1','1','1','2','102')
--15-- Vous serez 3 occupants et souhaitez le maximum de confort pour cette chambre dont le prix est 30% supérieur à la chambre la plus chère--

--16-- Le réglement de votre facture sera effectuée en CB

--17-- Une seconde facture a été éditée car le tarif a changé : rabais à 100%--

--18-- Comment faites-vous ? (Ceci ne remplace pas les traitements précédents)--

