local widget= require("widget")
local quiz = {
	question1 = {
		quetion_mark = "If you were infected with HIV, you might show symptoms",
		answer_mark = {
			"Within a few weeks ",
			"Within a year  ",
			"In 10 years or more",
			"Any of the above"
		},
		explanation = {
			explanation_correct = "Any of the above are true",
			explanation_wrong = "The answer is D, because any of the above are true"
		},
		right = 4
	},
	question2 = {
		quetion_mark = "How can you tell if someone has HIV or AIDS?",
		answer_mark = {
			"Because of the way they act.",
			"They look tired and ill",
			"There is no easy way to tell",
			"You could just guess"
		},
		explanation = {
			explanation_correct = "The Answer is C. There is no way of telling if a person is HIV positive just by looking as there are no specific symptoms of HIV , 	Anyone can carry HIV and still look and feel completely healthy",
			explanation_wrong = "The Answer is C. There is no way of telling if a person is HIV positive just by looking as there are no specific symptoms of HIV , 	Anyone can carry HIV and still look and feel completely healthy"
		},
		right = 3
	},
	question3 = {
		quetion_mark = "What is HIV ?",
		answer_mark = {
			"A fungus",
			"A virus",
			"A bacterium",
			"An insect"
		},
		explanation = {
			explanation_correct = "The Answer is B. HIV is a virus",
			explanation_wrong = "The Answer is B. HIV is a virus"
		},
		right = 2
	},
	question4 = {
		quetion_mark = "What does STD stand for ?",
		answer_mark = {
			"Sexually Transmitted Disease",
			"Special Treatment Doctor",
			"Standard Transmission Deficiency",
			"Send Then Death"
		},
		explanation = {
			explanation_correct = "The Answer is A. Sexually transmitted Diseases (STDs) can be passed on during sex",
			explanation_wrong = " 	The Answer is A. Sexually transmitted Diseases (STDs) can be passed on during sex"
		},
		right = 1
	},
	question5 = {
		quetion_mark = "Stigma and discrimination are the major obstacles to effective HIV/AIDS treatment and care",
		answer_mark = {
			"True",
			"False",
			"I dont know",
			"I dought"
		},
		explanation = {
			explanation_correct = "The Answer is True.",
			explanation_wrong = "The Answer is True."
		},
		right = 1
	},
	question6 = {
		quetion_mark = "What does HIV stand for?",
		answer_mark = {
			"Human Immunodeficiency Virus",
			"Harmful Intravenous Virus",
			"Human Injury Vaccine",
			"Hommon Introducing Vitamins"
		},
		explanation = {
			explanation_correct = "The Answer is A. Human Immunodeficiency Virus is the full term for HIV, which means that HIV weakens the body's immune system.",
			explanation_wrong = "The Answer is A. Human Immunodeficiency Virus is the full term for HIV, which means that HIV weakens the body's immune system."
		},
		right = 1
	},
	question7 = {
		quetion_mark = "An AIDS diagnosis means",
		answer_mark = {
			"Your immune system has weakened significantly",
			"You are susceptible to numerous infections",
			"You may qualify for disability payments",
			"All of the Above"
		},
		explanation = {
			explanation_correct = "The Answer is D. What distinguishes AIDS from HIV is the stage of infection in your body. Only when the virus has won the battle against your immune system and you begin having serious symptoms ",
			explanation_wrong = "The Answer is D. What distinguishes AIDS from HIV is the stage of infection in your body. Only when the virus has won the battle against your immune system and you begin having serious symptoms "
		},
		right = 4
	},
	question8 = {
		quetion_mark = "What is the difference between HIV and AIDS?",
		answer_mark = {
			"HIV is a virus and AIDS is a bacteria",
			"There is no difference between HIV and AIDS",
			"HIV is the virus that causes AIDS",
			"HIV is very bad, while STDs are not"
		},
		explanation = {
			explanation_correct = "The Answer is C. HIV is the virus that causes AIDS. A person is said to have AIDS when they develop an HIV related illness",
			explanation_wrong = "The Answer is C. HIV is the virus that causes AIDS. A person is said to have AIDS when they develop an HIV related illness"
		},
		right = 3
	},
	question9 = {
		quetion_mark = "What is abstinence ?",
		answer_mark = {
			"To lose your virginity",
			"To only have sex with one partner",
			"To refrain from sex ",
			"To keep in church"
		},
		explanation = {
			explanation_correct = "The Answer is C. Abstinence means avoiding sex. It is encouraged for people who are not married",
			explanation_wrong = "The Answer is C. Abstinence means avoiding sex. It is encouraged for people who are not married"
		},
		right = 3
	},
	question10 = {
		quetion_mark = "HIV can make a person ill because",
		answer_mark = {
			"It causes a person to lose weight very suddenly",
			"It attacks the immune system",
			"it reduces the body's core temperature",
			"You loose appetite"
		},
		explanation = {
			explanation_correct = "The Answer is B. HIV affects a person's immune system, which makes them more vulnerable to infections, and can make them very ill.",
			explanation_wrong = "The Answer is B. HIV affects a person's immune system, which makes them more vulnerable to infections, and can make them very ill."
		},
		right = 2
	},
	question11 = {
		quetion_mark = "Sharing the common cup with someone who is HIV positive puts HIV negative people at risk of infection",
		answer_mark = {
			"True",
			"False",
			"Both",
			"None"
		},
		explanation = {
			explanation_correct = "The Answer is False - HIV is not transmitted through saliva and is not spread through sharing the common cup.",
			explanation_wrong = "The Answer is False - HIV is not transmitted through saliva and is not spread through sharing the common cup."
		},
		right = 1
	},
	question12 = {
		quetion_mark = "Of the following tests, which would be the most likely to cause significant anxiety in most people",
		answer_mark = {
			"Test for Diabetes",
			"Test for High Blood Pressure",
			"Test for HIV",
			"Test for Glaucoma"
		},
		explanation = {
			explanation_correct = " 	The Answer is C For most people. The fear of testing positive for HIV creates tremendous anxiety ",
			explanation_wrong = " 	The Answer is CFor most people. The fear of testing positive for HIV creates tremendous anxiety "
		},
		right = 3
	},
	question13 = {
		quetion_mark = "Stigma and discrimination against those with HIV and AIDS",
		answer_mark = {
			"Doesn't happen often",
			"Discourages people from seeking treatment",
			"All of the above",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B. Because of stigma, lack of knowledge and fear, the rights of people living with HIV and AIDS and their families are frequently violated",
			explanation_wrong = "The Answer is B. Because of stigma, lack of knowledge and fear, the rights of people living with HIV and AIDS and their families are frequently violated"
		},
		right = 2
	},
	question14 = {
		quetion_mark = "Of the following tests, which would be the most likely to cause significant anxiety in most people",
		answer_mark = {
			"Test for Diabetes",
			"Test for High Blood Pressure",
			"Test for HIV",
			"Test for Glaucoma"
		},
		explanation = {
			explanation_correct = " 	The Answer is C For most people. The fear of testing positive for HIV creates tremendous anxiety ",
			explanation_wrong = " 	The Answer is CFor most people. The fear of testing positive for HIV creates tremendous anxiety "
		},
		right = 3
	},
	question15 = {
		quetion_mark = "After a person is infected with HIV, how long is it before the body's immune system begins to attack the virus with antibodies?",
		answer_mark = {
			"1 to 2 weeks",
			"4 to 8 weeks",
			"10 to 12 weeks",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B. The body takes 4 to 8 weeks to start attacking the virus and thus to begin to develop antibodies",
			explanation_wrong = "The Answer is B. The body takes 4 to 8 weeks to start attacking the virus and thus to begin to develop antibodies"
		},
		right = 2
	},
	question16 = {
		quetion_mark = "How long is HIV's so-called 'dormancy period' - when an infected person doesn't experience symptoms",
		answer_mark = {
			"Up to 6 months",
			"Up to 2 years",
			"Up to 10 years",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is C. In the first few weeks after infection, some people experience flu-like symptoms for a few days. But after that, on average, a person can go up to 10 years or more without experiencing any symptoms of HIV or AIDS",
			explanation_wrong = "The Answer is C. In the first few weeks after infection, some people experience flu-like symptoms for a few days. But after that, on average, a person can go up to 10 years or more without experiencing any symptoms of HIV or AIDS"
		},
		right = 3
	},
	question17 = {
		quetion_mark = "HIV infection, the virus that causes AIDS, is decreasing",
		answer_mark = {
			"True",
			"False",
			"Both",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is False. HIV continues to increase throughout the world. However, in certain countries, and certain sub-populations, there has been a decrease in HIV transmission due to education and changing of at-risk behavior.",
			explanation_wrong = "The Answer is False. HIV continues to increase throughout the world. However, in certain countries, and certain sub-populations, there has been a decrease in HIV transmission due to education and changing of at-risk behavior."
		},
		right = 1
	},
	question18 = {
		quetion_mark = "Which statement is true?",
		answer_mark = {
			"Without access to treatment, most people with AIDS will die within six month to two years.",
			"Many people have HIV and do not know it",
			"All of the above.",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is C. most people with HIV do not know that they are infected",
			explanation_wrong = "The Answer is C. most people with HIV do not know that they are infected"
		},
		right = 3
	},
	question19 = {
		quetion_mark = "HIV is easily preventable",
		answer_mark = {
			"True",
			"False",
			"Both",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is true. The key is prevention. You should not engage in sexual intercourse without using a condom, unless you are in a monogamous relationship with an uninfected partner",
			explanation_wrong = "The Answer is true. The key is prevention. You should not engage in sexual intercourse without using a condom, unless you are in a monogamous relationship with an uninfected partner"
		},
		right = 1
	},
	question20 = {
		quetion_mark = "The term men who have sex with men (MSM) refers to",
		answer_mark = {
			"Gay men only",
			"All men who have sex with other men, regardless of how they identify themselves (gay, bisexual, or heterosexual)",
			"Men on the down-low",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B All men who have sex with other men, regardless of how they identify themselves (gay, bisexual, or heterosexual).",
			explanation_wrong = "The Answer is B All men who have sex with other men, regardless of how they identify themselves (gay, bisexual, or heterosexual)."
		},
		right = 2
	},
	question21 = {
		quetion_mark = "The rates of risky behaviors are higher among young Men who have Sex with Men (MSM)  than among older MSM.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True Not having seen firsthand the toll of AIDS in the early years of the epidemic, young MSM may be less motivated to practice safer sex.",
			explanation_wrong = "The Answer is True Not having seen firsthand the toll of AIDS in the early years of the epidemic, young MSM may be less motivated to practice safer sex."
		},
		right = 1
	},
	question22 = {
		quetion_mark = "In heterosexual sex, who is more likely to become infected with HIV from an HIV positive partner?",
		answer_mark = {
			"The man",
			"The woman",
			"Either, equally",
			"I dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B. The woman, Male to female transmission of the HIV virus is about 8 times more efficient than female to male transmission.",
			explanation_wrong = "The Answer is B. The woman, Male to female transmission of the HIV virus is about 8 times more efficient than female to male transmission."
		},
		right = 2
	},
	question23 = {
		quetion_mark = "HIV can be transmitted from mother to child through...",
		answer_mark = {
			"Using the same toilet",
			"Sharing food or drink",
			"Delivery/Breastfeeding",
			"All of the above"
		},
		explanation = {
			explanation_correct = "The Answer is C. Delivery/Breastfeeding",
			explanation_wrong = "The Answer is C. Delivery/Breastfeeding"
		},
		right = 3
	},
	question24 = {
		quetion_mark = "In the future, how might a micro biocide help women protect themselves against HIV ?",
		answer_mark = {
			"By killing HIV inside the vagina without a partner knowing",
			"By stopping the HIV from developing in the body",
			"By reducing viral load",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is A.By killing HIV inside the vagina without a partner knowing",
			explanation_wrong = "The Answer is A.By killing HIV inside the vagina without a partner knowing"
		},
		right = 1
	},
	question25 = {
		quetion_mark = "What is the primary mode of transmission of HIV among Africans ?",
		answer_mark = {
			"Blood transfusion",
			"Unprotected sex",
			"Injection drug use",
			"Sharing Sharp instruments"
		},
		explanation = {
			explanation_correct = "The Answer is B. The primary mode of transmission among Africans is unprotected sexual contact - over 75 percent, followed by mother to child transmission",
			explanation_wrong = "The Answer is B. The primary mode of transmission among Africans is unprotected sexual contact - over 75 percent, followed by mother to child transmission"
		},
		right = 2
	},
	question26 = {
		quetion_mark = "A lesbian can be infected with HIV",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True",
			explanation_wrong = "The Answer is True"
		},
		right = 1
	},
	question27 = {
		quetion_mark = "Heterosexual women are at a low risk of HIV infection.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is False. Heterosexual women are the fastest growing population with HIV. Condoms, testing and having a single sexual partner may help prevent transmission of HIV and other STDs",
			explanation_wrong = "The Answer is False. Heterosexual women are the fastest growing population with HIV. Condoms, testing and having a single sexual partner may help prevent transmission of HIV and other STDs"
		},
		right = 2
	},
	question28 = {
		quetion_mark = "Babies can get HIV from their mothers",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is true. Women who are HIV positive can pass the virus to their babies.",
			explanation_wrong = "The Answer is true. Women who are HIV positive can pass the virus to their babies."
		},
		right = 1
	},
	question29 = {
		quetion_mark = "Women represent what percentage of people living with HIV and AIDS globally ?",
		answer_mark = {
			"Almost 15 percent",
			"Almost 25 percent",
			"Almost 50 percent",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is C. Almost 50 percent of the people living with HIV in the world are women.",
			explanation_wrong = "The Answer is C. Almost 50 percent of the people living with HIV in the world are women."
		},
		right = 3
	},
	question30 = {
		quetion_mark = "If an HIV positive woman takes the correct drugs and doesn't breastfeed, how likely is her baby to be born with HIV ?",
		answer_mark = {
			"Less than 2 percent",
			"Around 15 percent",
			"Greater than 40 percent",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is A. Less than 2 percent",
			explanation_wrong = "The Answer is A. Less than 2 percent"
		},
		right = 1
	},
	question31 = {
		quetion_mark = "What can the contraceptive pill protect a woman from ?",
		answer_mark = {
			"Pregnancy",
			"HIV",
			"Herpes",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is A. Pregnancy",
			explanation_wrong = "The Answer is A. Pregnancy"
		},
		right = 1
	},
	question32 = {
		quetion_mark = "What is the leading HIV-associated disease in developing countries ?",
		answer_mark = {
			"The common cold",
			"TB",
			"Pneumonia",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B.  TB is the leading cause of death among HIV positive people, as it accounts for up to a third of AIDS deaths worldwide.",
			explanation_wrong = "The Answer is B.  TB is the leading cause of death among HIV positive people, as it accounts for up to a third of AIDS deaths worldwide."
		},
		right = 2
	},
	question33 = {
		quetion_mark = "Using protection such as a latex barrier when performing sex (vaginal, oral or anal) lowers the risk of HIV transmission.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True.",
			explanation_wrong = "The Answer is True."
		},
		right = 1
	},
	question34 = {
		quetion_mark = "Which protects you most against HIV infection?",
		answer_mark = {
			"Condoms",
			"Contraceptive pills",
			"Spermicide jelly",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is A.Condoms are the most effective way to protect against transmission of HIV and  other STDs during sex.",
			explanation_wrong = "The Answer is A.Condoms are the most effective way to protect against transmission of HIV and  other STDs during sex. "
		},
		right = 1
	},
	question35 = {
		quetion_mark = "HIV is treatable.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is true. Yes, there are many new drugs available to treat HIV. Currently, if you are HIV positive, it is important to get regular health care and take your medications.",
			explanation_wrong = "The Answer is true. Yes, there are many new drugs available to treat HIV. Currently, if you are HIV positive, it is important to get regular health care and take your medications."
		},
		right = 1
	},
	question36 = {
		quetion_mark = "New HIV/AIDS drug treatments have lowered the number of AIDS-related deaths ",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True.",
			explanation_wrong = "The Answer is True."
		},
		right = 1
	},
	question37 = {
		quetion_mark = "Is there a cure for AIDS ?",
		answer_mark = {
			"Only for the wealthy ",
			"Available only by prescription ",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is C. There is no cure for AIDS. There are retroviral drugs that, used in combination, reduce the 'viral load' or the amount of HIV in infected people. ",
			explanation_wrong = "The Answer is C. There is no cure for AIDS. There are retroviral drugs that, used in combination, reduce the 'viral load' or the amount of HIV in infected people. "
		},
		right = 3
	},
	question38 = {
		quetion_mark = "Which of the following statements is true ?",
		answer_mark = {
			"Every minute, a child under the age of 15 dies of an AIDS-related disease",
			"Every minute, four children are orphaned by AIDS",
			"Every minute, another child becomes HIV positive",
			"All of the above"
		},
		explanation = {
			explanation_correct = "The Answer is B. Every minute, four children are orphaned by AIDS",
			explanation_wrong = "The Answer is B. Every minute, four children are orphaned by AIDS"
		},
		right = 2
	},
	question39 = {
		quetion_mark = "Worldwide, which of the following is the most common way that HIV is transmitted?",
		answer_mark = {
			"Sex between a man and a woman",
			"Sex between 2 men",
			"Sex between 2 women",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is A. Worldwide, most people get HIV through heterosexual sex (sex between a woman and a man). In some Western countries the virus has affected mostly gay men",
			explanation_wrong = "The Answer is A. Worldwide, most people get HIV through heterosexual sex (sex between a woman and a man). In some Western countries the virus has affected mostly gay men"
		},
		right = 1
	},
	question40 = {
		quetion_mark = "Teens, the elderly, newborns",
		answer_mark = {
			"College professors, the homeless, men, women and all ethnic groups",
			"Bisexual, gay, straight, transgender people",
			"All of the Above",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is D.Individuals of any group can be at risk of infection by HIV and AIDS.",
			explanation_wrong = "The Answer is D.Individuals of any group can be at risk of infection by HIV and AIDS."
		},
		right = 4
	},
	question41 = {
		quetion_mark = "Young people who have dropped out of school are more likely to become sexually active at younger ages and to fail to use contraception.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True.",
			explanation_wrong = "The Answer is True."
		},
		right = 1
	},
	question42 = {
		quetion_mark = "Young women are at risk for HIV infection through",
		answer_mark = {
			"Breastfeeding",
			"having unprotected sex",
			"Injection in hospitals",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B. having unprotected sex",
			explanation_wrong = "The Answer is B. having unprotected sex"
		},
		right = 2
	},
	question43 = {
		quetion_mark = "Young women are at risk for sexually transmitted HIV including",
		answer_mark = {
			"lack of recognition of their partners' risk factors",
			"inequality in relationships",
			"having sex with older men who are more likely to be infected with HIV",
			"All of the above"
		},
		explanation = {
			explanation_correct = "The Answer is D. All of the above",
			explanation_wrong = "The Answer is D. All of the above"
		},
		right = 4
	},
	question44 = {
		quetion_mark = "Most young people are infected through",
		answer_mark = {
			"Experimentation with drugs",
			"Sex",
			"Perinatal HIV transmission",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is B. According to the CDC, most young people with HIV/AIDS were infected by sexual transmission",
			explanation_wrong = "The Answer is B. According to the CDC, most young people with HIV/AIDS were infected by sexual transmission"
		},
		right = 2
	},
	question45 = {
		quetion_mark = "Stigma is the same as discrimination",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is False Stigma and discrimination share some of the same issues. However, discrimination is more easily understood while stigma has many subtleties",
			explanation_wrong = "The Answer is False Stigma and discrimination share some of the same issues. However, discrimination is more easily understood while stigma has many subtleties"
		},
		right = 2
	},
	question46 = {
		quetion_mark = "Of the following tests, which would be the most likely to cause significant anxiety in most people",
		answer_mark = {
			"Test for Diabetes",
			"Test for High Blood Pressure",
			"Test for HIV",
			"Test for Glaucoma"
		},
		explanation = {
			explanation_correct = "The Answer is C   For most people. The fear of testing positive for HIV creates tremendous anxiety ",
			explanation_wrong = "The Answer is C   For most people. The fear of testing positive for HIV creates tremendous anxiety "
		},
		right = 3
	},
	question47 = {
		quetion_mark = "If you live in a small rural community, what might be the best location for getting an HIV test?",
		answer_mark = {
			"The local health department",
			"Personal physician",
			"A testing site in a large city nearby",
			"Anywhere the test is offered"
		},
		explanation = {
			explanation_correct = "The Answer is C. A testing site in a large city nearby may be the best option because anonymity is often very important to prevent your HIV status from becoming known in the local community.",
			explanation_wrong = "The Answer is C. A testing site in a large city nearby may be the best option because anonymity is often very important to prevent your HIV status from becoming known in the local community."
		},
		right = 3
	},
	question48 = {
		quetion_mark = "HIV/AIDS is primarily a health issue only for gay or bisexual men",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is False - HIV/AIDS infection affects anyone engaged in unprotected sexual activities and/or injecting drug use.",
			explanation_wrong = "The Answer is False - HIV/AIDS infection affects anyone engaged in unprotected sexual activities and/or injecting drug use."
		},
		right = 2
	},
	question49 = {
		quetion_mark = "Which of the following words should be associated with the issue of stigma?",
		answer_mark = {
			"Assumptions",
			"Shame",
			"Rejection",
			"All of them"
		},
		explanation = {
			explanation_correct = "The Answer is All of them",
			explanation_wrong = "The Answer is All of them"
		},
		right = 4
	},
	question50 = {
		quetion_mark = "People who are infected with HIV are often blamed for their situation.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True - Although most adults engage in sexual activity, and many have had risk factors for HIV infection, many blame those who had the misfortune to contract the virus",
			explanation_wrong = "The Answer is True - Although most adults engage in sexual activity, and many have had risk factors for HIV infection, many blame those who had the misfortune to contract the virus"
		},
		right = 1
	},
	question51 = {
		quetion_mark = "HIV-related stigma only refers to a negative perception of the method by which a person acquired HIV infection",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is False- HIV-related stigma refers to all unfavorable attitudes, beliefs, and policies directed at those living with HIV or AIDS",
			explanation_wrong = "The Answer is False- HIV-related stigma refers to all unfavorable attitudes, beliefs, and policies directed at those living with HIV or AIDS"
		},
		right = 2
	},
	question52 = {
		quetion_mark = "HIV testing is influenced by HIV-related stigma",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True - Many people avoid being tested for HIV because they do not want to be associated in any way with it. ",
			explanation_wrong = "The Answer is True - Many people avoid being tested for HIV because they do not want to be associated in any way with it. "
		},
		right = 1
	},
	question53 = {
		quetion_mark = "Sharing the common cup with someone who is HIV positive puts HIV negative people at risk of infection",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is False - HIV is not transmitted through saliva and is not spread through sharing the common cup",
			explanation_wrong = "The Answer is False - HIV is not transmitted through saliva and is not spread through sharing the common cup"
		},
		right = 2
	},
	question54 = {
		quetion_mark = "HIV-related stigma refers to all unfavorable attitudes, beliefs, and policies directed at those living with HIV or AIDS",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True - However, unfavorable attitudes, beliefs, and policies may also be directed at the person's family, friends, social groups or community",
			explanation_wrong = "The Answer is True - However, unfavorable attitudes, beliefs, and policies may also be directed at the person's family, friends, social groups or community"
		},
		right = 2
	},
	question55 = {
		quetion_mark = "Stigma affects all aspects of HIV prevention, diagnosis, treatment, and care.",
		answer_mark = {
			"True",
			"False",
			"Both",
			"i dont know"
		},
		explanation = {
			explanation_correct = "The Answer is True - Stigma may increase new HIV infections because it can discourage people from getting tested",
			explanation_wrong = "The Answer is True - Stigma may increase new HIV infections because it can discourage people from getting tested"
		},
		right = 1
	},
	question54 = {
		quetion_mark = "What is the best way to protect yourself against HIV?",
		answer_mark = {
			"Get yourself vaccinated for HIV",
			"Use oral contraceptives",
			"Use a latex condom during sexual intercourse",
			"B and C"
		},
		explanation = {
			explanation_correct = "The correct answer is C. Use a latex condom during sexual intercourse ",
			explanation_wrong = "The correct answer is C. Use a latex condom during sexual intercourse "
		},
		right = 3
	},
	question55 = {
		quetion_mark = "Why is a combination of drugs-—called a cocktail-—used to treat HIV?",
		answer_mark = {
			"The virus mutates rapidly",
			"Each individual responds to each medication differently",
			"Combining medications triples their strength",
			"A and B"
		},
		explanation = {
			explanation_correct = "The correct answer is D. A and B . individual responds to each medication differently and Combining medications triples their strength",
			explanation_wrong = "The correct answer is D. A and B . individual responds to each medication differently and Combining medications triples their strength"
		},
		right = 4
	},
	question56 = {
		quetion_mark = "The risk for AIDS is attributed to behaviors. Which of these behaviors can put you at risk?",
		answer_mark = {
			"Spending time with someone who has AIDS",
			"Not wearing latex condoms during sex",
			"Injecting drugs",
			"B and C"
		},
		explanation = {
			explanation_correct = "The correct answer is D",
			explanation_wrong = "The correct answer is D"
		},
		right = 4
	},
	question57 = {
		quetion_mark = "HIV attacks a specific kind of cell in the immune system. Which is it?",
		answer_mark = {
			"Red blood cells",
			"White blood cells called T cells",
			"Platelets",
			"Epithelial cells"
		},
		explanation = {
			explanation_correct = "The correct answer is B. White blood cells called T cells .HIV targets a kind of white blood cell called a CD4 positive T cell, or T4 cell",
			explanation_wrong = "The correct answer is B. White blood cells called T cells .HIV targets a kind of white blood cell called a CD4 positive T cell, or T4 cell"
		},
		right = 2
	},
	question58 = {
		quetion_mark = "What does HIV-positive mean ?",
		answer_mark = {
			"Either antibodies against HIV or the virus particles themselves are present in the blood",
			"You have been tested for HIV",
			"Your white cell count is high",
			"You have been informed about HIV"
		},
		explanation = {
			explanation_correct = "The Answer is A. Either antibodies against HIV or the virus particles themselves are present in the blood",
			explanation_wrong = "The Answer is A. Either antibodies against HIV or the virus particles themselves are present in the blood"
		},
		right = 1
	},
}
function quiz:new(number)
	local qui = self["question"..number]



	local function onSwitchPress( event )
	    local switch = event.target
	    answered = switch.id
	    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
	end

	local dialog_group= display.newGroup()

	local scrollView = widget.newScrollView
	{
		left = display.screenOriginX+10,
		top = 40,
		width = display.actualContentWidth-20,
		height = display.actualContentHeight-50,
		bottomPadding = 50,
		id = "onBottom",
		horizontalScrollDisabled = true,
		verticalScrollDisabled = false,
		hideBackground = true,
		listener = function( event )
			local phase = event.phase
			local direction = event.direction	
			if "began" == phase then
				--print( "Began" )
			elseif "moved" == phase then
				--print( "Moved" )
			elseif "ended" == phase then
				--print( "Ended" )
			end	
			
			-- If the scrollView has reached it's scroll limit
			if event.limitReached then
				if "up" == direction then
					print( "Reached Top Limit" )
				elseif "down" == direction then
					print( "Reached Bottom Limit" )
				elseif "left" == direction then
					print( "Reached Left Limit" )
				elseif "right" == direction then
					print( "Reached Right Limit" )
				end
			end
			return true
		end
	}

	

    local dialog= display.newRoundedRect(display.screenOriginX+2,2,display.actualContentWidth -4,display.contentHeight-4,10)
	dialog.anchorX=0
	dialog.anchorY=0
	dialog:setFillColor(0,0,0)
	dialog.alpha=0.8


	local dialog_title= display.newRoundedRect(display.screenOriginX+2,2,display.actualContentWidth-4,30,10)
	dialog_title.anchorX=0
	dialog_title.anchorY=0
	dialog_title:setFillColor(0,0,0)

	local title_text = display.newText("Quiz",(display.contentWidth/2)-30,2,native.SystemFontBold,30)
	title_text.anchorX=0
	title_text.anchorY=0

    local fontRatio = 1.5
	local downPadding = 20
	local widthCharacters = 56.0
	local function getLines(num)
		if num < widthCharacters then
			return 1
		end
		ratio = (num * 1.0 ) / widthCharacters
		ratio = math.ceil( ratio )
		print( "The ratio is " .. ratio)
		return ratio;
	end
	local answer_group=display.newGroup()

	local question_text=display.newText(
		qui.quetion_mark,
		8,
		5,
		display.actualContentWidth-20,
		gameFont * fontRatio * getLines(#(qui.quetion_mark)),
		native.SystemFontBold,
		gameFont
	)
	question_text.anchorX=0
	question_text.anchorY=0
	--question_text:setFillColor( 0, 0, 0 )

	local answer1_text=display.newText(
		"A.  " .. qui.answer_mark[1],
		display.screenOriginX+62,
		question_text.y + question_text.height + downPadding,
		display.actualContentWidth-45,
		gameFont * fontRatio * getLines(#(qui.answer_mark[1]) + 4),
		native.SystemFontBold,
		gameFont
	)
	answer1_text.anchorX=0
	answer1_text.anchorY=0
	--answer1_text:setFillColor( 0, 0, 0 )

    
	
	local answer2_text=display.newText(
		"B.  " .. qui.answer_mark[2],
		display.screenOriginX+62,
		answer1_text.y + answer1_text.height + downPadding,
		display.actualContentWidth-45,
		gameFont * fontRatio * getLines(#(qui.answer_mark[2]) + 4),
		native.SystemFontBold,
		gameFont
	)
	answer2_text.anchorX=0
	answer2_text.anchorY=0
	--answer2_text:setFillColor( 0, 0, 0 )

	
	local answer3_text=display.newText(
		"C.  " .. qui.answer_mark[3],
		display.screenOriginX+62,
		answer2_text.y + answer2_text.height + downPadding,
		display.actualContentWidth-45,
		gameFont * fontRatio * getLines(#(qui.answer_mark[3]) + 4),
		native.SystemFontBold,
		gameFont
	)
	answer3_text.anchorX=0
	answer3_text.anchorY=0
	--answer3_text:setFillColor( 0, 0, 0 )


	
	local answer4_text=display.newText(
		"D.  " .. qui.answer_mark[4],
		display.screenOriginX+62,
		answer3_text.y + answer3_text.height + downPadding,
		display.actualContentWidth-45,
		gameFont * fontRatio * getLines(#(qui.answer_mark[4]) + 4),
		native.SystemFontBold,
		gameFont
	)
	answer4_text.anchorX=0
	answer4_text.anchorY=0
	--answer4_text:setFillColor( 0, 0, 0 )
	

	local answers={ answer1_text,answer2_text,answer3_text,answer4_text}

	for i=1,#answers do
		answer_group:insert(answers[i])
	end


	local radio_group= display.newGroup()
	radio_group.anchorX = 0
	radio_group.anchorY = 0
	radio_group.x=display.screenOriginX+8
	radio_group.y=answer1_text.y

	local radioButton1 = widget.newSwitch
	{
	    left = 20,
	    top = 0-8,
	    style = "radio",
	    id = 1,
	    onPress = onSwitchPress
	}
	radio_group:insert( radioButton1 )
	local radioButton2 = widget.newSwitch
	{
	    left = 20,
	    top = answer2_text.y - answer1_text.y - 8,
	    style = "radio",
	    id = 2,
	    onPress = onSwitchPress
	}
	radio_group:insert( radioButton2 )
	local radioButton3 = widget.newSwitch
	{
	    left = 20,
	    top = radioButton2.y  + (answer3_text.y - answer2_text.y - 16),
	    style = "radio",
	    id = 3,
	    onPress = onSwitchPress
	}
	radio_group:insert( radioButton3 )
	local radioButton4 = widget.newSwitch
	{
	    left = 20,
	    top = radioButton3.y  + (answer4_text.y - answer3_text.y - 16),
	    style = "radio",
	    id = 4,
	    onPress = onSwitchPress
	}
	radio_group:insert( radioButton4 )

	local ok_text=display.newText("OK",105,answer4_text.y+ answer4_text.height +20,native.SystemFontBold,25)
	ok_text.anchorX=0
	ok_text.anchorY=0
	ok_text.number = number
	--ok_text:setFillColor( 0, 0, 0 )
	ok_text:addEventListener("touch",function ( event )
		
		ok_text.parent.parent.alpha = 0	
		local quim = self["question"..ok_text.number ]


		local dialog_group_answer= display.newGroup()

		local whatsapp = ""
		local explanation = ""
		
		if answered == quim.right then
			whatsapp = "Correct, "
			explanation = quim.explanation.explanation_correct
			sc = math.random(30,50)
			playerScore = playerScore + sc
			scoreText.text = "Score: " .. playerScore
			whatsapp = whatsapp .. " you have scored " .. sc .. " points"
		else
			whatsapp = "Wrong"
			explanation = quim.explanation.explanation_wrong
		end

		local complement_text=display.newText(whatsapp,50,(display.contentHeight/2)-110,native.SystemFontBold,gameFont + 2)
		complement_text.anchorX=0
		complement_text.anchorY=0
		
		local explanation_text=display.newText("Explanation :",50,(display.contentHeight/2)-70,native.SystemFontBold,gameFont + 2)
		explanation_text.anchorX=0
		explanation_text.anchorY=0
		local realString= explanation
		-- local expscroll  = widget.newScrollView
		-- {
		-- 	left = 50,
		-- 	top = 120,
		-- 	width = display.contentWidth - 100,
		-- 	height = 120,
		-- 	bottomPadding = 5,
		-- 	topPadding = 10,
		-- 	leftPadding = 5,
		-- 	rightPadding = 20,
		-- 	id = "onBottom",
		-- 	backgroundColor = { 0, 0, 0 ,0 },
		-- 	horizontalScrollDisabled = true,
		-- 	verticalScrollDisabled = false
		-- }
		local real_explanation_text=display.newText("\n" .. realString  ,50,(display.contentHeight/2)-70,display.contentWidth - 100,120,native.SystemFontBold,gameFont)
		real_explanation_text.anchorX=0
		real_explanation_text.anchorY=0
		--expscroll:insert(real_explanation_text)
		local ok_text2=display.newText("OK",205,(display.contentHeight/2)+80,native.SystemFontBold,25)
		ok_text2.anchorX=0
		ok_text2.anchorY=0
		ok_text2:addEventListener("touch",function ( event )
			dialog_group.alpha = 0
			ok_text2.parent.alpha = 0
			modez = "normal"
			plays = 0
			return true;
		end)
		

		dialog_group_answer:insert(complement_text)
		dialog_group_answer:insert(explanation_text)
		dialog_group_answer:insert(real_explanation_text)
		dialog_group_answer:insert(ok_text2)

		--dialog_group_answer.alpha=0
		dialog_group_answer.alpha = 1
		
		-- dd.alpha = 1
		-- parent  = dd.parent
		-- parent:insert( dd )
		-- dd.isFocus = true
		return true;
	end)

	dialog_group:insert(dialog)
	dialog_group:insert(dialog_title)
	dialog_group:insert(title_text)

	scrollView:insert(question_text)
	scrollView:insert(answer_group)
	scrollView:insert(radio_group)
	scrollView:insert(ok_text)
	
	dialog_group:insert(scrollView)
	

	-- dialog_group:insert(dialog)
	-- dialog_group:insert(dialog_title)
	-- dialog_group:insert(title_text)
	-- dialog_group:insert(radio_group)
	-- dialog_group:insert(answer_group)
	-- dialog_group:insert(question_text)
	-- dialog_group:insert(ok_text)


	--dialog_group.alpha = 0

	

end

return quiz