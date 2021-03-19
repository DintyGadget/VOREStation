import { createSearch, decodeHtmlEntities } from 'common/string';
import { Fragment } from 'inferno';
import { useBackend, useLocalState } from '../backend';
import { Box, Button, Flex, Input, Section, Table, Tabs, NoticeBox, LabeledList } from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';

const MAX_SEARCH_RESULTS = 25;

export const Uplink = (props, context) => {
  const { data } = useBackend(context);

  const [screen, setScreen] = useLocalState(context, 'screen', 0);
  
  const { telecrystals } = data;
  return (
    <Window
      width={620}
      height={580}
      theme="syndicate"
      resizable>
      <Window.Content scrollable>
        <UplinkHeader screen={screen} setScreen={setScreen} />
        {screen === 0 && (
          <GenericUplink
            currencyAmount={telecrystals}
            currencySymbol="TC" />
        ) || screen === 1 && (
          <ExploitableInformation />
        ) || (
          <Section color="bad">
            Ошибка
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};

const UplinkHeader = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    screen,
    setScreen,
  } = props;

  const {
    discount_name,
    discount_amount,
    offer_expiry,
  } = data;

  return (
    <Section>
      <Tabs style={{
        "border-bottom": "none",
        "margin-bottom": "0",
      }}>
        <Tabs.Tab
          selected={screen === 0}
          onClick={() => setScreen(0)}>
          Запрос предметов
        </Tabs.Tab>
        <Tabs.Tab
          selected={screen === 1}
          onClick={() => setScreen(1)}>
          Эксплуатируемая Информация
        </Tabs.Tab>
      </Tabs>
      <Section title="Скидка на товар" level={2}>
        {discount_amount < 100 && (
          <Box>
            {discount_name} - {discount_amount}% off. Offer expires at: {offer_expiry}
          </Box>
        ) || (
          <Box>
            В настоящее время нет товаров со скидкой.
          </Box>
        )}
      </Section>
    </Section>
  );
};

const ExploitableInformation = (props, context) => {
  const { act, data } = useBackend(context);

  const {
    exploit,
    locked_records,
  } = data;

  return (
    <Section title="Эксплуатируемая Информация" buttons={exploit && (
      <Button
        icon="undo"
        content="Назад"
        onClick={() => act("view_exploits", { id: 0 })} />
    )}>
      {exploit && (
        <Box>
          <LabeledList>
            <LabeledList.Item label="Ф.И">
              {exploit.name}
            </LabeledList.Item>
            <LabeledList.Item label="Пол">
              {exploit.sex}
            </LabeledList.Item>
            <LabeledList.Item label="Раса">
              {exploit.species}
            </LabeledList.Item>
            <LabeledList.Item label="Возраст">
              {exploit.age}
            </LabeledList.Item>
            <LabeledList.Item label="Должность">
              {exploit.rank}
            </LabeledList.Item>
            <LabeledList.Item label="Родная система">
              {exploit.home_system}
            </LabeledList.Item>
            <LabeledList.Item label="Гражданство">
              {exploit.citizenship}
            </LabeledList.Item>
            <LabeledList.Item label="Фракция">
              {exploit.faction}
            </LabeledList.Item>
            <LabeledList.Item label="Религия">
              {exploit.religion}
            </LabeledList.Item>
            <LabeledList.Item label="Отпечаток">
              {exploit.fingerprint}
            </LabeledList.Item>
            <LabeledList.Item label="Другие Принадлежности">
              {exploit.antagfaction}
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item>Acquired Information</LabeledList.Item>
            <LabeledList.Item label="Заметки">
              {exploit.nanoui_exploit_record}
            </LabeledList.Item>
          </LabeledList>
        </Box>
      ) || locked_records.map(record => (
        <Button
          key={record.id}
          icon="eye"
          fluid
          content={record.name}
          onClick={() => act("view_exploits", { id: record.id })} />
      ))}
    </Section>
  );
};

export const GenericUplink = (props, context) => {
  const {
    currencyAmount = 0,
    currencySymbol = '₮',
  } = props;
  const { act, data } = useBackend(context);
  const {
    compactMode,
    lockable,
    categories = [],
  } = data;
  const [
    searchText,
    setSearchText,
  ] = useLocalState(context, 'searchText', '');
  const [
    selectedCategory,
    setSelectedCategory,
  ] = useLocalState(context, 'category', categories[0]?.name);
  const testSearch = createSearch(searchText, item => {
    return item.name + item.desc;
  });
  const items = searchText.length > 0
    // Flatten all categories and apply search to it
    && categories
      .flatMap(category => category.items || [])
      .filter(testSearch)
      .filter((item, i) => i < MAX_SEARCH_RESULTS)
    // Select a category and show all items in it
    || categories
      .find(category => category.name === selectedCategory)
      ?.items
    // If none of that results in a list, return an empty list
    || [];
  return (
    <Section
      title={(
        <Box
          inline
          color={currencyAmount > 0 ? 'good' : 'bad'}>
          {formatMoney(currencyAmount)} {currencySymbol}
        </Box>
      )}
      buttons={(
        <Fragment>
          Поиск
          <Input
            autoFocus
            value={searchText}
            onInput={(e, value) => setSearchText(value)}
            mx={1} />
          <Button
            icon={compactMode ? 'list' : 'info'}
            content={compactMode ? 'Компактный' : 'Подробный'}
            onClick={() => act('compact_toggle')} />
          {!!lockable && (
            <Button
              icon="lock"
              content="Закр."
              onClick={() => act('lock')} />
          )}
        </Fragment>
      )}>
      <Flex>
        {searchText.length === 0 && (
          <Flex.Item>
            <Tabs vertical>
              {categories.map(category => (
                <Tabs.Tab
                  key={category.name}
                  selected={category.name === selectedCategory}
                  onClick={() => setSelectedCategory(category.name)}>
                  {category.name} ({category.items?.length || 0})
                </Tabs.Tab>
              ))}
            </Tabs>
          </Flex.Item>
        )}
        <Flex.Item grow={1} basis={0}>
          {items.length === 0 && (
            <NoticeBox>
              {searchText.length === 0
                ? 'Нет предметов в этой категории.'
                : 'Результатов не найдено.'}
            </NoticeBox>
          )}
          <ItemList
            compactMode={searchText.length > 0 || compactMode}
            currencyAmount={currencyAmount}
            currencySymbol={currencySymbol}
            items={items} />
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const ItemList = (props, context) => {
  const {
    compactMode,
    currencyAmount,
    currencySymbol,
  } = props;
  const { act } = useBackend(context);
  const [
    hoveredItem,
    setHoveredItem,
  ] = useLocalState(context, 'hoveredItem', {});
  const hoveredCost = hoveredItem && hoveredItem.cost || 0;
  // Append extra hover data to items
  const items = props.items.map(item => {
    const notSameItem = hoveredItem && hoveredItem.name !== item.name;
    const notEnoughHovered = currencyAmount - hoveredCost < item.cost;
    const disabledDueToHovered = notSameItem && notEnoughHovered;
    const disabled = currencyAmount < item.cost || disabledDueToHovered;
    return {
      ...item,
      disabled,
    };
  });
  if (compactMode) {
    return (
      <Table>
        {items.map(item => (
          <Table.Row
            key={item.name}
            className="candystripe">
            <Table.Cell bold>
              {decodeHtmlEntities(item.name)}
            </Table.Cell>
            <Table.Cell collapsing textAlign="right">
              <Button
                fluid
                content={formatMoney(item.cost) + ' ' + currencySymbol}
                disabled={item.disabled}
                tooltip={item.desc}
                tooltipPosition="left"
                onmouseover={() => setHoveredItem(item)}
                onmouseout={() => setHoveredItem({})}
                onClick={() => act('buy', {
                  ref: item.ref,
                })} />
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    );
  }
  return items.map(item => (
    <Section
      key={item.name}
      title={item.name}
      level={2}
      buttons={(
        <Button
          content={item.cost + ' ' + currencySymbol}
          disabled={item.disabled}
          onmouseover={() => setHoveredItem(item)}
          onmouseout={() => setHoveredItem({})}
          onClick={() => act('buy', {
            ref: item.ref,
          })} />
      )}>
      {decodeHtmlEntities(item.desc)}
    </Section>
  ));
};
