/// ISO 639-1 代码表
class LocalizedString {
  /// 获取值
  String value() {
    return toJson().values.firstWhere((localize) => localize != null);
  }

  String? afar;
  String? abkhazian;
  String? avestan;
  String? afrikaans;
  String? akan;
  String? amharic;
  String? aragonese;
  String? arabic;
  String? assamese;
  String? avaric;
  String? aymara;
  String? azerbaijani;
  String? bashkir;
  String? belarusian;
  String? bulgarian;
  String? biharilanguages;
  String? bislama;
  String? bambara;
  String? bengali;
  String? tibetan;
  String? breton;
  String? bosnian;
  String? catalanValencian;
  String? chechen;
  String? chamorro;
  String? corsican;
  String? cree;
  String? czech;
  String? church;
  String? chuvash;
  String? welsh;
  String? danish;
  String? german;
  String? divehiDhivehiMaldivian;
  String? dzongkha;
  String? ewe;
  String? greekModern;
  String? english;
  String? esperanto;
  String? spanish;
  String? latinAmericanSpanish;
  String? estonian;
  String? basque;
  String? persian;
  String? fulah;
  String? finnish;
  String? fijian;
  String? faroese;
  String? french;
  String? westernFrisian;
  String? irish;
  String? gaelicScomttishGaelic;
  String? galician;
  String? guarani;
  String? gujarati;
  String? manx;
  String? hausa;
  String? hebrew;
  String? hindi;
  String? hiriMotu;
  String? croatian;
  String? haitianHaitianCreole;
  String? hungarian;
  String? armenian;
  String? herero;
  String? interlingua;
  String? indonesian;
  String? interlingueOccidental;
  String? igbo;
  String? sichuanYiNuosu;
  String? inupiaq;
  String? ido;
  String? icelandic;
  String? italian;
  String? inuktitut;
  String? japanese;
  String? romanizedJapanese;
  String? javanese;
  String? georgian;
  String? kongo;
  String? kikuyuGikuyu;
  String? kuanyamaKwanyama;
  String? kazakh;
  String? kalaallisutGreenlandic;
  String? centralKhmer;
  String? kannada;
  String? korean;
  String? romanizedKorean;
  String? kanuri;
  String? kashmiri;
  String? kurdish;
  String? komi;
  String? cornish;
  String? kirghizKyrgyz;
  String? latin;
  String? luxembourgishLetzeburgesch;
  String? ganda;
  String? limburganLimburgerLimburgish;
  String? lingala;
  String? lao;
  String? lithuanian;
  String? lubaKatanga;
  String? latvian;
  String? malagasy;
  String? marshallese;
  String? maori;
  String? macedonian;
  String? malayalam;
  String? mongolian;
  String? marathi;
  String? malay;
  String? maltese;
  String? burmese;
  String? nauru;
  String? bokmalNorwegianNorwegianBokmal;
  String? ndebeleNorthNorthNdebele;
  String? nepali;
  String? ndonga;
  String? dutchFlemish;
  String? norwegianNynorskNynorskNorwegian;
  String? norwegian;
  String? ndebeleSouthSouthNdebele;
  String? navajoNavaho;
  String? chichewaChewaNyanja;
  String? occitan;
  String? ojibwa;
  String? oromo;
  String? oriya;
  String? ossetianOssetic;
  String? panjabiPunjabi;
  String? pali;
  String? polish;
  String? pushtoPashto;
  String? portuguese;
  String? brazilianPortugese;
  String? quechua;
  String? romansh;
  String? rundi;
  String? romanianMoldavianMoldovan;
  String? russian;
  String? kinyarwanda;
  String? sanskrit;
  String? sardinian;
  String? sindhi;
  String? northernSami;
  String? sango;
  String? sinhalaSinhalese;
  String? slovak;
  String? slovenian;
  String? samoan;
  String? shona;
  String? somali;
  String? albanian;
  String? serbian;
  String? swati;
  String? sothoSouthern;
  String? sundanese;
  String? swedish;
  String? swahili;
  String? tamil;
  String? telugu;
  String? tajik;
  String? thai;
  String? tigrinya;
  String? turkmen;
  String? tagalog;
  String? tswana;
  String? tonga;
  String? turkish;
  String? tsonga;
  String? tatar;
  String? twi;
  String? tahitian;
  String? uighurUyghur;
  String? ukrainian;
  String? urdu;
  String? uzbek;
  String? venda;
  String? vietnamese;
  String? volapuk;
  String? walloon;
  String? wolof;
  String? xhosa;
  String? yiddish;
  String? yoruba;
  String? zhuangChuang;
  String? simplifiedChinese;
  String? traditionalChinese;
  String? romanizedChinese;
  String? zulu;

  LocalizedString({
    this.afar,
    this.abkhazian,
    this.avestan,
    this.afrikaans,
    this.akan,
    this.amharic,
    this.aragonese,
    this.arabic,
    this.assamese,
    this.avaric,
    this.aymara,
    this.azerbaijani,
    this.bashkir,
    this.belarusian,
    this.bulgarian,
    this.biharilanguages,
    this.bislama,
    this.bambara,
    this.bengali,
    this.tibetan,
    this.breton,
    this.bosnian,
    this.catalanValencian,
    this.chechen,
    this.chamorro,
    this.corsican,
    this.cree,
    this.czech,
    this.church,
    this.chuvash,
    this.welsh,
    this.danish,
    this.german,
    this.divehiDhivehiMaldivian,
    this.dzongkha,
    this.ewe,
    this.greekModern,
    this.english,
    this.esperanto,
    this.spanish,
    this.latinAmericanSpanish,
    this.estonian,
    this.basque,
    this.persian,
    this.fulah,
    this.finnish,
    this.fijian,
    this.faroese,
    this.french,
    this.westernFrisian,
    this.irish,
    this.gaelicScomttishGaelic,
    this.galician,
    this.guarani,
    this.gujarati,
    this.manx,
    this.hausa,
    this.hebrew,
    this.hindi,
    this.hiriMotu,
    this.croatian,
    this.haitianHaitianCreole,
    this.hungarian,
    this.armenian,
    this.herero,
    this.interlingua,
    this.indonesian,
    this.interlingueOccidental,
    this.igbo,
    this.sichuanYiNuosu,
    this.inupiaq,
    this.ido,
    this.icelandic,
    this.italian,
    this.inuktitut,
    this.japanese,
    this.romanizedJapanese,
    this.javanese,
    this.georgian,
    this.kongo,
    this.kikuyuGikuyu,
    this.kuanyamaKwanyama,
    this.kazakh,
    this.kalaallisutGreenlandic,
    this.centralKhmer,
    this.kannada,
    this.korean,
    this.romanizedKorean,
    this.kanuri,
    this.kashmiri,
    this.kurdish,
    this.komi,
    this.cornish,
    this.kirghizKyrgyz,
    this.latin,
    this.luxembourgishLetzeburgesch,
    this.ganda,
    this.limburganLimburgerLimburgish,
    this.lingala,
    this.lao,
    this.lithuanian,
    this.lubaKatanga,
    this.latvian,
    this.malagasy,
    this.marshallese,
    this.maori,
    this.macedonian,
    this.malayalam,
    this.mongolian,
    this.marathi,
    this.malay,
    this.maltese,
    this.burmese,
    this.nauru,
    this.bokmalNorwegianNorwegianBokmal,
    this.ndebeleNorthNorthNdebele,
    this.nepali,
    this.ndonga,
    this.dutchFlemish,
    this.norwegianNynorskNynorskNorwegian,
    this.norwegian,
    this.ndebeleSouthSouthNdebele,
    this.navajoNavaho,
    this.chichewaChewaNyanja,
    this.occitan,
    this.ojibwa,
    this.oromo,
    this.oriya,
    this.ossetianOssetic,
    this.panjabiPunjabi,
    this.pali,
    this.polish,
    this.pushtoPashto,
    this.portuguese,
    this.brazilianPortugese,
    this.quechua,
    this.romansh,
    this.rundi,
    this.romanianMoldavianMoldovan,
    this.russian,
    this.kinyarwanda,
    this.sanskrit,
    this.sardinian,
    this.sindhi,
    this.northernSami,
    this.sango,
    this.sinhalaSinhalese,
    this.slovak,
    this.slovenian,
    this.samoan,
    this.shona,
    this.somali,
    this.albanian,
    this.serbian,
    this.swati,
    this.sothoSouthern,
    this.sundanese,
    this.swedish,
    this.swahili,
    this.tamil,
    this.telugu,
    this.tajik,
    this.thai,
    this.tigrinya,
    this.turkmen,
    this.tagalog,
    this.tswana,
    this.tonga,
    this.turkish,
    this.tsonga,
    this.tatar,
    this.twi,
    this.tahitian,
    this.uighurUyghur,
    this.ukrainian,
    this.urdu,
    this.uzbek,
    this.venda,
    this.vietnamese,
    this.volapuk,
    this.walloon,
    this.wolof,
    this.xhosa,
    this.yiddish,
    this.yoruba,
    this.zhuangChuang,
    this.simplifiedChinese,
    this.traditionalChinese,
    this.romanizedChinese,
    this.zulu,
  });

  factory LocalizedString.fromJson(Map<String, dynamic> json) =>
      LocalizedString(
        afar: json['aa'] as String?,
        abkhazian: json['ab'] as String?,
        avestan: json['ae'] as String?,
        afrikaans: json['af'] as String?,
        akan: json['ak'] as String?,
        amharic: json['am'] as String?,
        aragonese: json['an'] as String?,
        arabic: json['ar'] as String?,
        assamese: json['as'] as String?,
        avaric: json['av'] as String?,
        aymara: json['ay'] as String?,
        azerbaijani: json['az'] as String?,
        bashkir: json['ba'] as String?,
        belarusian: json['be'] as String?,
        bulgarian: json['bg'] as String?,
        biharilanguages: json['bh'] as String?,
        bislama: json['bi'] as String?,
        bambara: json['bm'] as String?,
        bengali: json['bn'] as String?,
        tibetan: json['bo'] as String?,
        breton: json['br'] as String?,
        bosnian: json['bs'] as String?,
        catalanValencian: json['ca'] as String?,
        chechen: json['ce'] as String?,
        chamorro: json['ch'] as String?,
        corsican: json['co'] as String?,
        cree: json['cr'] as String?,
        czech: json['cs'] as String?,
        church: json['cu'] as String?,
        chuvash: json['cv'] as String?,
        welsh: json['cy'] as String?,
        danish: json['da'] as String?,
        german: json['de'] as String?,
        divehiDhivehiMaldivian: json['dv'] as String?,
        dzongkha: json['dz'] as String?,
        ewe: json['ee'] as String?,
        greekModern: json['el'] as String?,
        english: json['en'] as String?,
        esperanto: json['eo'] as String?,
        spanish: json['es'] as String?,
        latinAmericanSpanish: json['es-la'] as String?,
        estonian: json['et'] as String?,
        basque: json['eu'] as String?,
        persian: json['fa'] as String?,
        fulah: json['ff'] as String?,
        finnish: json['fi'] as String?,
        fijian: json['fj'] as String?,
        faroese: json['fo'] as String?,
        french: json['fr'] as String?,
        westernFrisian: json['fy'] as String?,
        irish: json['ga'] as String?,
        gaelicScomttishGaelic: json['gd'] as String?,
        galician: json['gl'] as String?,
        guarani: json['gn'] as String?,
        gujarati: json['gu'] as String?,
        manx: json['gv'] as String?,
        hausa: json['ha'] as String?,
        hebrew: json['he'] as String?,
        hindi: json['hi'] as String?,
        hiriMotu: json['ho'] as String?,
        croatian: json['hr'] as String?,
        haitianHaitianCreole: json['ht'] as String?,
        hungarian: json['hu'] as String?,
        armenian: json['hy'] as String?,
        herero: json['hz'] as String?,
        interlingua: json['ia'] as String?,
        indonesian: json['id'] as String?,
        interlingueOccidental: json['ie'] as String?,
        igbo: json['ig'] as String?,
        sichuanYiNuosu: json['ii'] as String?,
        inupiaq: json['ik'] as String?,
        ido: json['io'] as String?,
        icelandic: json['is'] as String?,
        italian: json['it'] as String?,
        inuktitut: json['iu'] as String?,
        japanese: json['ja'] as String?,
        romanizedJapanese: json['ja-ro'] as String?,
        javanese: json['jv'] as String?,
        georgian: json['ka'] as String?,
        kongo: json['kg'] as String?,
        kikuyuGikuyu: json['ki'] as String?,
        kuanyamaKwanyama: json['kj'] as String?,
        kazakh: json['kk'] as String?,
        kalaallisutGreenlandic: json['kl'] as String?,
        centralKhmer: json['km'] as String?,
        kannada: json['kn'] as String?,
        korean: json['ko'] as String?,
        romanizedKorean: json['ko-ro'] as String?,
        kanuri: json['kr'] as String?,
        kashmiri: json['ks'] as String?,
        kurdish: json['ku'] as String?,
        komi: json['kv'] as String?,
        cornish: json['kw'] as String?,
        kirghizKyrgyz: json['ky'] as String?,
        latin: json['la'] as String?,
        luxembourgishLetzeburgesch: json['lb'] as String?,
        ganda: json['lg'] as String?,
        limburganLimburgerLimburgish: json['li'] as String?,
        lingala: json['ln'] as String?,
        lao: json['lo'] as String?,
        lithuanian: json['lt'] as String?,
        lubaKatanga: json['lu'] as String?,
        latvian: json['lv'] as String?,
        malagasy: json['mg'] as String?,
        marshallese: json['mh'] as String?,
        maori: json['mi'] as String?,
        macedonian: json['mk'] as String?,
        malayalam: json['ml'] as String?,
        mongolian: json['mn'] as String?,
        marathi: json['mr'] as String?,
        malay: json['ms'] as String?,
        maltese: json['mt'] as String?,
        burmese: json['my'] as String?,
        nauru: json['na'] as String?,
        bokmalNorwegianNorwegianBokmal: json['nb'] as String?,
        ndebeleNorthNorthNdebele: json['nd'] as String?,
        nepali: json['ne'] as String?,
        ndonga: json['ng'] as String?,
        dutchFlemish: json['nl'] as String?,
        norwegianNynorskNynorskNorwegian: json['nn'] as String?,
        norwegian: json['no'] as String?,
        ndebeleSouthSouthNdebele: json['nr'] as String?,
        navajoNavaho: json['nv'] as String?,
        chichewaChewaNyanja: json['ny'] as String?,
        occitan: json['oc'] as String?,
        ojibwa: json['oj'] as String?,
        oromo: json['om'] as String?,
        oriya: json['or'] as String?,
        ossetianOssetic: json['os'] as String?,
        panjabiPunjabi: json['pa'] as String?,
        pali: json['pi'] as String?,
        polish: json['pl'] as String?,
        pushtoPashto: json['ps'] as String?,
        portuguese: json['pt'] as String?,
        brazilianPortugese: json['pt-br'] as String?,
        quechua: json['qu'] as String?,
        romansh: json['rm'] as String?,
        rundi: json['rn'] as String?,
        romanianMoldavianMoldovan: json['ro'] as String?,
        russian: json['ru'] as String?,
        kinyarwanda: json['rw'] as String?,
        sanskrit: json['sa'] as String?,
        sardinian: json['sc'] as String?,
        sindhi: json['sd'] as String?,
        northernSami: json['se'] as String?,
        sango: json['sg'] as String?,
        sinhalaSinhalese: json['si'] as String?,
        slovak: json['sk'] as String?,
        slovenian: json['sl'] as String?,
        samoan: json['sm'] as String?,
        shona: json['sn'] as String?,
        somali: json['so'] as String?,
        albanian: json['sq'] as String?,
        serbian: json['sr'] as String?,
        swati: json['ss'] as String?,
        sothoSouthern: json['st'] as String?,
        sundanese: json['su'] as String?,
        swedish: json['sv'] as String?,
        swahili: json['sw'] as String?,
        tamil: json['ta'] as String?,
        telugu: json['te'] as String?,
        tajik: json['tg'] as String?,
        thai: json['th'] as String?,
        tigrinya: json['ti'] as String?,
        turkmen: json['tk'] as String?,
        tagalog: json['tl'] as String?,
        tswana: json['tn'] as String?,
        tonga: json['to'] as String?,
        turkish: json['tr'] as String?,
        tsonga: json['ts'] as String?,
        tatar: json['tt'] as String?,
        twi: json['tw'] as String?,
        tahitian: json['ty'] as String?,
        uighurUyghur: json['ug'] as String?,
        ukrainian: json['uk'] as String?,
        urdu: json['ur'] as String?,
        uzbek: json['uz'] as String?,
        venda: json['ve'] as String?,
        vietnamese: json['vi'] as String?,
        volapuk: json['vo'] as String?,
        walloon: json['wa'] as String?,
        wolof: json['wo'] as String?,
        xhosa: json['xh'] as String?,
        yiddish: json['yi'] as String?,
        yoruba: json['yo'] as String?,
        zhuangChuang: json['za'] as String?,
        simplifiedChinese: json['zh'] as String?,
        traditionalChinese: json['zh-hk'] as String?,
        romanizedChinese: json['zh-ro'] as String?,
        zulu: json['zu'] as String?,
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('afar', afar);
    writeNotNull('abkhazian', abkhazian);
    writeNotNull('avestan', avestan);
    writeNotNull('afrikaans', afrikaans);
    writeNotNull('akan', akan);
    writeNotNull('amharic', amharic);
    writeNotNull('aragonese', aragonese);
    writeNotNull('arabic', arabic);
    writeNotNull('assamese', assamese);
    writeNotNull('avaric', avaric);
    writeNotNull('aymara', aymara);
    writeNotNull('azerbaijani', azerbaijani);
    writeNotNull('bashkir', bashkir);
    writeNotNull('belarusian', belarusian);
    writeNotNull('bulgarian', bulgarian);
    writeNotNull('biharilanguages', biharilanguages);
    writeNotNull('bislama', bislama);
    writeNotNull('bambara', bambara);
    writeNotNull('bengali', bengali);
    writeNotNull('tibetan', tibetan);
    writeNotNull('breton', breton);
    writeNotNull('bosnian', bosnian);
    writeNotNull('catalanValencian', catalanValencian);
    writeNotNull('chechen', chechen);
    writeNotNull('chamorro', chamorro);
    writeNotNull('corsican', corsican);
    writeNotNull('cree', cree);
    writeNotNull('czech', czech);
    writeNotNull('church', church);
    writeNotNull('chuvash', chuvash);
    writeNotNull('welsh', welsh);
    writeNotNull('danish', danish);
    writeNotNull('german', german);
    writeNotNull('divehiDhivehiMaldivian', divehiDhivehiMaldivian);
    writeNotNull('dzongkha', dzongkha);
    writeNotNull('ewe', ewe);
    writeNotNull('greekModern', greekModern);
    writeNotNull('english', english);
    writeNotNull('esperanto', esperanto);
    writeNotNull('spanish', spanish);
    writeNotNull('latinAmericanSpanish', latinAmericanSpanish);
    writeNotNull('estonian', estonian);
    writeNotNull('basque', basque);
    writeNotNull('persian', persian);
    writeNotNull('fulah', fulah);
    writeNotNull('finnish', finnish);
    writeNotNull('fijian', fijian);
    writeNotNull('faroese', faroese);
    writeNotNull('french', french);
    writeNotNull('westernFrisian', westernFrisian);
    writeNotNull('irish', irish);
    writeNotNull('gaelicScomttishGaelic', gaelicScomttishGaelic);
    writeNotNull('galician', galician);
    writeNotNull('guarani', guarani);
    writeNotNull('gujarati', gujarati);
    writeNotNull('manx', manx);
    writeNotNull('hausa', hausa);
    writeNotNull('hebrew', hebrew);
    writeNotNull('hindi', hindi);
    writeNotNull('hiriMotu', hiriMotu);
    writeNotNull('croatian', croatian);
    writeNotNull('haitianHaitianCreole', haitianHaitianCreole);
    writeNotNull('hungarian', hungarian);
    writeNotNull('armenian', armenian);
    writeNotNull('herero', herero);
    writeNotNull('interlingua', interlingua);
    writeNotNull('indonesian', indonesian);
    writeNotNull('interlingueOccidental', interlingueOccidental);
    writeNotNull('igbo', igbo);
    writeNotNull('sichuanYiNuosu', sichuanYiNuosu);
    writeNotNull('inupiaq', inupiaq);
    writeNotNull('ido', ido);
    writeNotNull('icelandic', icelandic);
    writeNotNull('italian', italian);
    writeNotNull('inuktitut', inuktitut);
    writeNotNull('japanese', japanese);
    writeNotNull('romanizedJapanese', romanizedJapanese);
    writeNotNull('javanese', javanese);
    writeNotNull('georgian', georgian);
    writeNotNull('kongo', kongo);
    writeNotNull('kikuyuGikuyu', kikuyuGikuyu);
    writeNotNull('kuanyamaKwanyama', kuanyamaKwanyama);
    writeNotNull('kazakh', kazakh);
    writeNotNull('kalaallisutGreenlandic', kalaallisutGreenlandic);
    writeNotNull('centralKhmer', centralKhmer);
    writeNotNull('kannada', kannada);
    writeNotNull('korean', korean);
    writeNotNull('romanizedKorean', romanizedKorean);
    writeNotNull('kanuri', kanuri);
    writeNotNull('kashmiri', kashmiri);
    writeNotNull('kurdish', kurdish);
    writeNotNull('komi', komi);
    writeNotNull('cornish', cornish);
    writeNotNull('kirghizKyrgyz', kirghizKyrgyz);
    writeNotNull('latin', latin);
    writeNotNull('luxembourgishLetzeburgesch', luxembourgishLetzeburgesch);
    writeNotNull('ganda', ganda);
    writeNotNull('limburganLimburgerLimburgish', limburganLimburgerLimburgish);
    writeNotNull('lingala', lingala);
    writeNotNull('lao', lao);
    writeNotNull('lithuanian', lithuanian);
    writeNotNull('lubaKatanga', lubaKatanga);
    writeNotNull('latvian', latvian);
    writeNotNull('malagasy', malagasy);
    writeNotNull('marshallese', marshallese);
    writeNotNull('maori', maori);
    writeNotNull('macedonian', macedonian);
    writeNotNull('malayalam', malayalam);
    writeNotNull('mongolian', mongolian);
    writeNotNull('marathi', marathi);
    writeNotNull('malay', malay);
    writeNotNull('maltese', maltese);
    writeNotNull('burmese', burmese);
    writeNotNull('nauru', nauru);
    writeNotNull(
        'bokmalNorwegianNorwegianBokmal', bokmalNorwegianNorwegianBokmal);
    writeNotNull('ndebeleNorthNorthNdebele', ndebeleNorthNorthNdebele);
    writeNotNull('nepali', nepali);
    writeNotNull('ndonga', ndonga);
    writeNotNull('dutchFlemish', dutchFlemish);
    writeNotNull(
        'norwegianNynorskNynorskNorwegian', norwegianNynorskNynorskNorwegian);
    writeNotNull('norwegian', norwegian);
    writeNotNull('ndebeleSouthSouthNdebele', ndebeleSouthSouthNdebele);
    writeNotNull('navajoNavaho', navajoNavaho);
    writeNotNull('chichewaChewaNyanja', chichewaChewaNyanja);
    writeNotNull('occitan', occitan);
    writeNotNull('ojibwa', ojibwa);
    writeNotNull('oromo', oromo);
    writeNotNull('oriya', oriya);
    writeNotNull('ossetianOssetic', ossetianOssetic);
    writeNotNull('panjabiPunjabi', panjabiPunjabi);
    writeNotNull('pali', pali);
    writeNotNull('polish', polish);
    writeNotNull('pushtoPashto', pushtoPashto);
    writeNotNull('portuguese', portuguese);
    writeNotNull('brazilianPortugese', brazilianPortugese);
    writeNotNull('quechua', quechua);
    writeNotNull('romansh', romansh);
    writeNotNull('rundi', rundi);
    writeNotNull('romanianMoldavianMoldovan', romanianMoldavianMoldovan);
    writeNotNull('russian', russian);
    writeNotNull('kinyarwanda', kinyarwanda);
    writeNotNull('sanskrit', sanskrit);
    writeNotNull('sardinian', sardinian);
    writeNotNull('sindhi', sindhi);
    writeNotNull('northernSami', northernSami);
    writeNotNull('sango', sango);
    writeNotNull('sinhalaSinhalese', sinhalaSinhalese);
    writeNotNull('slovak', slovak);
    writeNotNull('slovenian', slovenian);
    writeNotNull('samoan', samoan);
    writeNotNull('shona', shona);
    writeNotNull('somali', somali);
    writeNotNull('albanian', albanian);
    writeNotNull('serbian', serbian);
    writeNotNull('swati', swati);
    writeNotNull('sothoSouthern', sothoSouthern);
    writeNotNull('sundanese', sundanese);
    writeNotNull('swedish', swedish);
    writeNotNull('swahili', swahili);
    writeNotNull('tamil', tamil);
    writeNotNull('telugu', telugu);
    writeNotNull('tajik', tajik);
    writeNotNull('thai', thai);
    writeNotNull('tigrinya', tigrinya);
    writeNotNull('turkmen', turkmen);
    writeNotNull('tagalog', tagalog);
    writeNotNull('tswana', tswana);
    writeNotNull('tonga', tonga);
    writeNotNull('turkish', turkish);
    writeNotNull('tsonga', tsonga);
    writeNotNull('tatar', tatar);
    writeNotNull('twi', twi);
    writeNotNull('tahitian', tahitian);
    writeNotNull('uighurUyghur', uighurUyghur);
    writeNotNull('ukrainian', ukrainian);
    writeNotNull('urdu', urdu);
    writeNotNull('uzbek', uzbek);
    writeNotNull('venda', venda);
    writeNotNull('vietnamese', vietnamese);
    writeNotNull('volapuk', volapuk);
    writeNotNull('walloon', walloon);
    writeNotNull('wolof', wolof);
    writeNotNull('xhosa', xhosa);
    writeNotNull('yiddish', yiddish);
    writeNotNull('yoruba', yoruba);
    writeNotNull('zhuangChuang', zhuangChuang);
    writeNotNull('simplifiedChinese', simplifiedChinese);
    writeNotNull('traditionalChinese', traditionalChinese);
    writeNotNull('romanizedChinese', romanizedChinese);
    writeNotNull('zulu', zulu);
    return val;
  }
}
